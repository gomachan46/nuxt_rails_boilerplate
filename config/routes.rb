Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/api' do
    resources 'hello', only: [:index]
    get '*path', controller: 'application', action: 'render_404'
  end

  root to: 'static#index'
  get '*path', to: 'static#index', constraints: lambda { |req| req.path.exclude? 'rails' }
end
