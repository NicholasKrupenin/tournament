FactoryBot.define do
  sequence :name do |n|
    "team-#{n}"
  end

  factory :team do
    name
    division {'A'}
    score { 0 }
  end
end
