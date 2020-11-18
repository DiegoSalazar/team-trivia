class Play < ApplicationRecord
  belongs_to :trivia
  belongs_to :team
  belongs_to :submission
end
