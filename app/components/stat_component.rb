# frozen_string_literal: true

class StatComponent < ViewComponent::Base
  def initialize(stat_name, value)
    super
    @stat_name = stat_name
    @value = value
  end
end
