class ContributionsController < ApplicationController
  before_action :authenticate_player!

  def new
    @upcoming_trivia = Trivium.upcoming
  end
end
