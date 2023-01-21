# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      before_action :authenticate_user
      before_action :correct_user_search_param

      def index
        movies = Movie.search_movies(params)
        render json: movies
      end

      private

      def correct_user_search_param
        user = current_user
          head(:unauthorized) if params[:userId].to_i != user.id
      end

    end
  end
end
