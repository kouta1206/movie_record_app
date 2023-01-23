module MovieItems
    module PostService
    
        module_function


        def post(movie_params,  starring_params, genre_params)
            # TODO:確認事項（パーフォーマンス等,記述の仕方,実務は~はやらない等あればコメント下さい）
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
