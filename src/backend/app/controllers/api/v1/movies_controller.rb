# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      # protect_from_forgery
      before_action :authenticate_user
      # before_action :correct_user_search_param, only: [:index]
      before_action :correct_user_show_param, only: [:show]

      def index
        genres = Genre.all()
        render json: genres
      end

      def search
        # byebug
        movies = Movie.search_movies(search_params)
        render json: movies
      end

      def show
        movie = MovieItems::ShowService.show(params[:id])
        render json: movie
      end

      def create
        if MovieItems::PostService.post(movie_params, starring_params, genre_params)
            render json: { status: 200, message: 'Success!'}
        else
          render json: { status: 400, message: 'Bad Request'}
        end
      end

      private

      def correct_user_search_param
        user = current_user
          head(:unauthorized) if params[:userId].to_i != user.id
      end

      def correct_user_show_param
        movie = Movie.find(params[:id])
        head(:unauthorized) if current_user.id != movie.user_id
      end

      private

      def movie_params
        params.require(:movie).permit(:title, :image_path, :director, :release_at, :evaluation, :viewing_at, :review).merge(user_id: current_user.id)
      end

      def starring_params
        params.require(:starring).permit(name: [])
      end

      def genre_params
        params.require(:genre).permit(name: [])
      end

      def search_params
        params.permit(:title, :director, :image_path, :release_at, :evaluation, :viewing_at, :review, :viewingAtFrom, :viewingAtTo, :sortField, :order, :starring, :genre).merge(user_id: current_user.id)
      end

    end
  end
end
