class MovieStarring < ApplicationRecord
    belongs_to :movie
    belongs_to :starring
end
