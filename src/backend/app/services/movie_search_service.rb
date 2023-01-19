# frozen_string_literal: true

class MovieSearchService
  def initialize(user)
    @user = user
  end

 def search
    if params.include?('viewingAtFrom')
      # paramsのkeyに視聴期間が存在していれば、値を変数に代入
      viewing_at_from = params[:viewingAtFrom]
    end
    viewing_at_to = params[:viewingAtTo] if params.include?('viewingAtTo')
    if params.include?('sortField')
      # paramsのkeyにソート条件があれば、値を変数に代入
      sort_field = params[:sortField]
    end
    if params.include?('title')
      # paramsのkeyに映画のタイトルがあれば、値を変数に代入
      title = params[:title]
    end
    if params.include?('director')
      # paramsのkeyに映画の監督が存在していていれば、値を変数に代入
      director_name = params[:director]
    end
    if params.include?('evaluation')
      # paramsのkeyに評価数が指定されていたら、値を変数に代入
      evaluation = params[:evaluation]
    end
    if params.include?('starring')
      # paramsのkeyに俳優が指定されていたら、値を変数に代入
      starring_name = params[:starring]
    end
    if params.include?('genres')
      # paramsのkeyに俳優が指定されていたら、値を変数に代入
      genre_name = params[:genres]
    end
    # paramsに俳優とジャンルがあった場合の検索
    return unless starring_name.present?

    Movie.joins(:starrings, :genres).where(starrings: { name: starring_name }, genres: { name: genre_name },
                                            title: title, director: director_name, evaluation: evaluation, viewing_at: viewing_at_from..viewing_at_to)

    # paramsに俳優があった場合の検索
    # paramsにジャンルがあった場合の検索
    # paramsに俳優とジャンルがなかった場合の検索
  end
end
