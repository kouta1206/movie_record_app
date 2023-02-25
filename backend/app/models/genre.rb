class Genre < ApplicationRecord
    has_many :movie_genres
    has_many :movies, through: :movie_genres
    accepts_nested_attributes_for :movie_genres

    validates :name, presence: true,
                    length: {
                        maximum: 30
                    }
end
