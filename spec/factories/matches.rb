FactoryBot.define do
  factory :match do
    team
    game { Match.games.values.sample }
    status { Match.statuses.values.sample }
  end
end
