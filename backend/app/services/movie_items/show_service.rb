module MovieItems
    module ShowService

        module_function

        def show(id)
            # TODO:確認事項（パーフォーマンス等,記述の仕方,実務は~はやらない等あればコメント下さい）
            movie = Movie.find(id)
            starrings_name = movie.starrings.map {|starring| starring.name }
            genres_name = movie.genres.map {|genre| genre.name }
            {
                movie: movie,
                starrings: starrings_name,
                genres: genres_name
            }
        end
    end
end
