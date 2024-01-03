require 'rails_helper'

RSpec.describe MatchesController, type: :controller do
  describe 'GET #generate_results' do
    let!(:team_a) { create(:team, division: 'A', score: 13) }
    let!(:team_b) { create(:team, division: 'B', score: 17) }
    let!(:playoff_team_a) { create(:match, team: team_a, status: :win, game: :playoff_one) }
    let!(:playoff_team_b) { create(:match, team: team_b, status: :win, game: :playoff_one) }

    it 'creates playoff final result and redirects' do
      expect { get :generate_results }.to change(Match, :count).by(2)

      expect(Match.where(game: :playoff_final, status: :win).count).to eq 1
      expect(response).to redirect_to(:show)
    end
  end
end
