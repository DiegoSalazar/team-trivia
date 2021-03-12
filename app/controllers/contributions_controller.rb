class ContributionsController < ApplicationController
  before_action :authenticate_player!
  before_action :set_current_trivium

  def new
    @upcoming_trivia = Trivium.upcoming
  end
end
