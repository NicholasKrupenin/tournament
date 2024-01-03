require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should have_many(:matches).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:score) }
  it { should_not allow_value('C').for(:division) }
  it { should allow_value('A', 'B').for(:division) }

  subject { build(:team) }
  it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }

  describe 'class methods' do
    describe '.autogenerate_division' do
      it 'creates 16 teams with divisions A or B' do
        expect { Team.autogenerate_division }.to change(Team, :count).by(16)

        expect(Team.where(division: 'A').count).to eq(8)
        expect(Team.where(division: 'B').count).to eq(8)
      end
    end

    describe '.team_autogenerate' do
      it 'creates a team with a valid division' do
        team = Team.team_autogenerate(1) # You can pass any number

        expect(team).to be_valid
        expect(team.division).to match(/[A|B]/)
      end
    end
  end

  describe 'instance method' do
    let!(:team) { create(:team, division: 'A') }

    it 'update team score #add_score' do
      team.add_score
      expect(team.score).to be_within(10).of(0)
    end
  end
end
