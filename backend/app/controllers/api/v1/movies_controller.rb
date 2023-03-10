module Api
  module V1
    class MoviesController < ApplicationController
      before_action :authenticate_user
      before_action :correct_user_show_param, only: [:show]
      before_action :movie, only: [:show, :destroy, :update]

      def index
        movies = Movie.search_movies(search_params)
        count = movies.except(:limit, :offset).count
        res = {
          movies: movies,
          count: count
        }
        render json: res
      end

      def show
        render json: movie.serialize
      end

      def create
        Movie.create_movie(movie_params, starring_params, genre_params)
            head :created
        rescue ActiveRecord::RecordInvalid => e
            render json: { status: 400, message:  e.record.errors.full_messages}
      end

      def update
        movie.update_movie(movie_params, starring_params, genre_params)
          render json: {movie: movie, status: 200}
        rescue ActiveRecord::RecordInvalid => e
          render json: { status: 400, message:  e.record.errors.full_messages}
      end

      def destroy
        if movie.destroy
          head :ok
        else
          render json: movie.errors
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

      def movie
        @movie ||= Movie.find(params[:id])
      end


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
        params.permit(:title, :director, :image_path, :release_at, :evaluation, :viewing_at, :review, :viewingAtFrom, :viewingAtTo, :sortField, :order, :starring, :genre, :page).merge(user_id: current_user.id)
      end

    end
  end
end
