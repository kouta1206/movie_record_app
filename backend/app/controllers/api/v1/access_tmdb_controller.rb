module Api
    module V1
        class AccessTmdbController < ApplicationController

            def index
                @access_tmdb = AccessTmdb.all(search_params)
                render json: @access_tmdb
            end

            private
            def search_params
                params.permit(:value)
            end
        end
    end
end
