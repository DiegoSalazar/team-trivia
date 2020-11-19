# frozen_string_literal: true

class Join < ApplicationRecord
  belongs_to :team
  belongs_to :player
end
