module MovieItems
    module PostService
    
        module_function


        def post(movie_params)
            # TODO:確認事項（パーフォーマンス等,記述の仕方,実務は~はやらない等あればコメント下さい）
            @movie = Movie.new(movie_params.except(:starring_names, :genre_names))
            if  @movie.save!
                movie_params[:starring_names].map {|starring_name|
                    starring = Starring.find_or_create_by!(name: starring_name)
                    @movie.starrings << starring
                }
                movie_params[:genre_names].map {|genre_name|
                    genre = Genre.find_or_create_by!(name: genre_name)
                    @movie.genres << genre
                }
            end

        end
    end
end
