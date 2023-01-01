class Starring < ApplicationRecord
    has_many :movie_starrings
    has_many :movies, through: :movie_starrings
end
