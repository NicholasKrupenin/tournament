class Game
  DIVISION = %w[A B].freeze

  attr_reader :team, :stage, :stage_method

  def initialize(match)
    @team = match.fetch(:teams)
    @stage = match.fetch(:stage)
    @stage_method = match.fetch(:stage).split('_').first
  end

  def self.create(match)
    new(match).dispatch_result
  end

  def dispatch_result
    send("#{stage_method}_result")
  end

  def match_result
    DIVISION.each do |division|
      team.where(division: division).each_slice(2) do |teams|
        winner, defeat = teams.shuffle
        record_result(winner, defeat, stage)
      end
    end
  end

  def playoff_result
    playoff_team = team.order(score: :desc).to_a
    num = playoff_team.size / 2
    num.times do
      winner, defeat = [playoff_team.shift, playoff_team.pop].shuffle
      record_result(winner, defeat, stage)
    end
  end

  def record_result(winner, defeat, stage)
    winner.add_score
    Match.record_result(winner, defeat, stage)
  end
end
