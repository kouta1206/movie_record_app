module Api
    module V1
        class StarringsController < ApplicationController

            def index
                starrings = Starring.all()
                render json: starrings
            end

        end
    end
end
