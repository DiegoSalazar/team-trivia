# frozen_string_literal: true

class Join < ApplicationRecord
  belongs_to :team, dependent: :destroy
  belongs_to :player, dependent: :destroy
end
