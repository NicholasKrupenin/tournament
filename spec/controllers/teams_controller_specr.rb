require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  describe 'GET #start' do
    before { get :start }

    it 'renders start view' do
      expect(response).to render_template :start
    end
  end

  describe 'POST #new' do
    let(:team) { create(:team) }
    let!(:match) { create(:match, team: team) }

    before { post :new }

    it 'size an array' do
      expect(assigns(:team_a).size).to eq 8
      expect(assigns(:team_b).size).to eq 8
    end

    it 'sets a flash message' do

      expect(flash.now[:message]).to eq 'The team division is already established !!!'
    end
  end

  describe 'GET #draw_teams' do
    let!(:teams) { create_list(:team, 5) }

    before { get :draw_teams }

    it 'populates an array' do
      expect(assigns(:teams)).to match_array teams
    end
  end

  describe 'POST #autogenerate_divisions' do
    it 'creates teams with divisions' do
      expect { post :autogenerate_divisions }.to change(Team, :count).by(16)

      expect(Team.where(division: 'A').count).to eq(8)
      expect(Team.where(division: 'B').count).to eq(8)
    end

    it 'redirects' do
      post :autogenerate_divisions
      expect(response).to redirect_to(draw_teams_path)
    end
  end

  describe 'POST #generate_divisions' do
    let(:valid_params) do
      {
        team: {
          teams_attributes: {
            '0' => { 'name' => 'Team 1', 'division' => 'A' },
            '1' => { 'name' => 'Team 2', 'division' => 'A' }
          }
        }
      }
    end

    it 'creates teams and redirects' do
      post :generate_divisions, params: valid_params
      expect(response).to redirect_to(draw_teams_path)
      expect(flash[:notice]).to eq('Divisions have been successfully created.')
    end

    it 'creates teams with correct attributes' do
      expect { post :generate_divisions, params: valid_params }.to change(Team, :count).by(2)

      expect(Team.last.name).to eq('Team 2')
      expect(Team.last.division).to eq('A')
    end
  end
end
