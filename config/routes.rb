Rails.application.routes.draw do
  get '/new(.:format)', to: 'games#new'
  post '/score', to: 'games#score'
end
