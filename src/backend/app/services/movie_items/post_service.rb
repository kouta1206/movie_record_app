module MovieItems
    module PostService
    
        module_function


        def post(movie_params,  starring_params, genre_params)
            # TODO:確認事項（パーフォーマンス等,記述の仕方,実務は~はやらない等あればコメント下さい）
            @movie = Movie.new(movie_params)
            if  @movie.save!
                starring_params[:name].map {|starring_name|
                    @movie.starrings.find_or_create_by!(name: starring_name)
                }
                genre_params[:name].map {|genre_name|
                    @movie.genres.find_or_create_by!(name: genre_name)
                }
            end

        end
    end
end
