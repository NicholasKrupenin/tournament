class MatchesController < ApplicationController
  def generate_results
    match = Match.game_data
    Game.create(match)
    redirect_to :show, notice: "Result for #{match[:stage].humanize}"
  end
  def show
    @teams = Match.winning_teams
    @stage = Match.last
  end
end

