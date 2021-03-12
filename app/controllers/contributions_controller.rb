class ContributionsController < ApplicationController
  before_action :authenticate_player!
  before_action :set_current_trivium
  before_action :set_trivium

  def new
    @upcoming_trivia = Trivium.upcoming
  end

  private

  def set_trivium
    @trivium = Trivium.find params[:id]
  end
end
