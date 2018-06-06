require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # set :method_override, true
  end

  get '/recipes' do
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes/create' do
    recipe = Recipe.create(recipe_params)
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    recipe = params["id"]
    @recipe = Recipe.find(recipe)
    erb :show
  end

  get '/recipes/:id/edit' do
    recipe_id = params["id"]
    @recipe = Recipe.all.find(recipe_id)

    erb :edit
  end

  patch '/recipes/:id' do
    recipe_id = params["id"]
    @recipe = Recipe.all.find(recipe_id)

    @recipe.update(recipe_params)
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    recipe_id = params["id"]
    @recipe = Recipe.all.find(recipe_id)

    @recipe.delete
    redirect '/recipes'
  end

  private
  def recipe_params
    params["recipes"]
  end

end
