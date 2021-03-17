# frozen_string_literal: true

class JoinReflex < ApplicationReflex
  def team
    current_player.update! team_id: element.dataset.team_id
    controller.flash[:notice] = "You just joined Team #{current_player.team.name}!"
  end
end
