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
    inner_join_with_starrings(search_params[:starring])
        .inner_join_with_genres(search_params[:genre])
        .search_with_title(search_params[:title])
        .search_with_director(search_params[:director])
        .search_with_evaluation(search_params[:evaluation])
        .search_with_user_id(search_params[:user_id])
        .search_with_period(search_params)
        .sort_by_order(search_params)
        .limit_with_offset(search_params[:page])
end


scope :inner_join_with_starrings, -> (starring) { joins(:starrings)
    .where(starrings: {name: starring}) if starring.present? }

scope :inner_join_with_genres, -> (genre) { joins(:genres)
    .where(genres: {name: genre}) if genre.present? }

scope :search_with_title, -> (title) {
    where(title: title) if title.present? }

scope :search_with_user_id, -> (user_id) {
    where(user_id: user_id) if user_id.present?
}

scope :search_with_director, -> (director) {
    where(director: director) if director.present? }

scope :search_with_evaluation, ->  (evaluation) {
    where(evaluation: evaluation) if evaluation.present? }

scope :search_with_period, -> (search_params) {
    return if search_params[:viewingAtFrom].blank? && search_params[:viewingAtTo].blank?
    viewing_at_from = search_params[:viewingAtFrom]
    viewing_at_to = search_params[:viewingAtTo]
    where(viewing_at: (viewing_at_from)..(viewing_at_to)) }

scope :sort_by_order, -> (search_params) {
    return if search_params[:sortField].blank? && search_params[:order].blank?
    sort_field = search_params[:sortField]
    order = search_params[:order]
    order("#{sort_field} #{order}")}

scope :limit_with_offset, -> (page) {
    limit(5).offset(5 * (page.to_i - 1))  if page.present?
}

    def serialize
        as_json(include: [:starrings, :genres])
    end

    class << self

        def create_movie(movie_params,  starring_params, genre_params)
            transaction do
                movie = Movie.create!(movie_params)
                starring_params[:name].map {|starring_name|
                    movie.starrings.find_or_create_by!(name: starring_name)
                }
                genre_params[:name].map {|genre_name|
                    movie.genres.find_or_create_by!(name: genre_name)
                }
            end
        end

    end
end


