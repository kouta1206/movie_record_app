class Movie < ApplicationRecord
    has_many :movie_genres
    has_many :genres, through: :movie_genres
    has_many :movie_starrings
    has_many :starrings, through: :movie_starrings
    belongs_to :user 
end
