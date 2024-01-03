Rails.application.routes.draw do
    root 'teams#start'

    get 'draw_teams', to: 'teams#draw_teams'
    get 'generate_results', to: 'matches#generate_results'
    get 'show', to: 'matches#show'
    post 'new', to: 'teams#new'
    post 'autogenerate_divisions', to: 'teams#autogenerate_divisions'
    post 'generate_divisions', to: 'teams#generate_divisions'
    post 'generate_results', to: 'matches#generate_results'
end
