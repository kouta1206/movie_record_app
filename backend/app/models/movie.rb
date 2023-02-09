class Movie < ApplicationRecord
    has_many :movie_genres
    has_many :genres, through: :movie_genres
    has_many :movie_starrings
    has_many :starrings, through: :movie_starrings
    belongs_to :user

    validates :title, presence: true,
                        length: {
                            maximum:100
                        }
    validates :director, presence: true,
                        length: {
                            maximum: 50
                        }
    validates :evaluation, presence: true,
    # 評価は1~5までとする
                        numericality: {
                            only_integer: true,
                        },
                        inclusion: { in: (1..5),
                        message: :invalid_int_range
                        }

    validates :user_id, presence: true

    VALID_DATE_REGEX = /\A\d{4}-\d{2}-\d{2}\z/
    validates :viewing_at, presence: true,
                        format: {
                            with: VALID_DATE_REGEX,
                            message: :invalid_date
                        }

    validates :release_at, presence: true,
                        format: {
                            with: VALID_DATE_REGEX,
                            message: :invalid_date
                        }

    validates :review, presence: false,
    # レビューを書かず登録だけする事も許容する
                        length: {
                            maximum: 500
                        }



scope :search_movies, -> (search_params) do
    return if search_params.blank?
    res = self
    res = res.with_starrings(search_params[:starring]) if search_params[:starring].present?
    res = res.inner_join_with_genres(search_params[:genre]) if search_params[:genre].present?
    res = res.with_title(search_params[:title]) if search_params[:title].present?
    res = res.with_director(search_params[:director]) if search_params[:director].present?
    res = res.with_evaluation(search_params[:evaluation])if search_params[:evaluation].present?
    res = res.with_user_id(search_params[:user_id]) if search_params[:user_id].present?
    res = res.with_period(search_params) if search_params[:viewingAtFrom].present?
    res = res.sort_by_order(search_params) if search_params[:sortField].present?
    res = res.paginate(search_params[:page]) if search_params[:page].present?

    res
end


scope :with_starrings, -> (starring) { joins(:starrings)
    .where(starrings: {name: starring}) }

scope :inner_join_with_genres, -> (genre) { joins(:genres)
    .where(genres: {name: genre}) }

scope :with_title, -> (title) {
    where(title: title) }

scope :with_user_id, -> (user_id) {
    where(user_id: user_id)
}

scope :with_director, -> (director) {
    where(director: director) }

scope :with_evaluation, ->  (evaluation) {
    where(evaluation: evaluation) }

scope :with_period, -> (search_params) {
    viewing_at_from = search_params[:viewingAtFrom]
    viewing_at_to = search_params[:viewingAtTo]
    where(viewing_at: (viewing_at_from)..(viewing_at_to)) }

scope :sort_by_order, -> (search_params) {
    sort_field = search_params[:sortField]
    order = search_params[:order]
    order("#{sort_field} #{order}")}

scope :paginate, -> (page) {
    limit(5).offset(5 * (page.to_i - 1))
}

    class << self

        def show(id)
            movie = Movie.find(id)
            starrings_name = movie.starrings.map {|starring| starring.name }
            genres_name = movie.genres.map {|genre| genre.name }
            {
                movie: movie,
                starrings: starrings_name,
                genres: genres_name
            }
        end

        def create(movie_params,  starring_params, genre_params)
            @movie = Movie.new(movie_params)
            if  @movie.save!
                starring_params[:name].map {|starring_name|
                    starring = Starring.find_or_create_by!(name: starring_name)
                    @movie.starrings << starring
                }
                genre_params[:name].map {|genre_name|
                    genre = Genre.find_or_create_by!(name: genre_name)
                    @movie.genres << genre
                }
            end
        end
        
    end
end


