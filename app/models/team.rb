class Team < ApplicationRecord
  has_many :matches, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :score, presence: true, numericality: true
  validates :division, format: { with: /\A[A|B]?\z/,
                                    message: "%{value} is not a division A or B" }

  class << self
    def autogenerate_division
      Team.destroy_all
      16.times(&method(:team_autogenerate))
    end

    def team_autogenerate(number)
      Team.create(name: Faker::Sports::Football.unique.team, division: number < 8 ? 'A' : 'B')
    end
  end

  def add_score
    update(score: diff_score)
  end

  def diff_score
    score + rand(1..10)
  end
end
