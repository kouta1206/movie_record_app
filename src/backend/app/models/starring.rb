class Starring < ApplicationRecord
    has_many :movie_starrings
    has_many :movies, through: :movie_starrings

    validates :name, presence: true,
                            length: {
                                maximum: 30
                            }
end
