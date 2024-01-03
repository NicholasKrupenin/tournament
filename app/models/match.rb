class Match < ApplicationRecord
  belongs_to :team

  enum :game, { draw: 0, match_one: 1, match_two: 2, playoff_one: 3, playoff_final: 4 }
  enum :status, { win: 1, defeat: 0 }

  class << self
    def game_data
      reset_matches if playoff_final?
      create_initial_matches unless exists?
      { teams: winning_teams, stage: next_stage }
    end

    def next_stage
      games.key(current_stage_value + 1)
    end

    def current_stage_value
      games[last.game]
    end

    def create_initial_matches
      Team.all.each { |mate| Match.create(team: mate, game: :draw) }
    end

    def winning_teams
      Team.joins(:matches).where(matches: { game: current_stage_value, status: :win })
    end

    def record_result(winner, defeat, stage)
      create(team: winner, game: stage, status: :win)
      create(team: defeat, game: stage, status: :defeat)
    end

    def reset_matches
      destroy_all
    end

    def playoff_final?
      last&.playoff_final?
    end
  end
end
