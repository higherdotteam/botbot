Rails.application.routes.draw do
  root 'welcome#index'

  get 'slack' => 'bot#auth'
  post 'slack' => 'bot#event'

end
