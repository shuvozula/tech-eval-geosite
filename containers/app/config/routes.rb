Rails.application.routes.draw do
  get 'cogs/list'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'cogs#list'
end
