require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
    erb :index
  end

  get '/recipes' do
    @all_recipes = Recipe.all
    erb :recipes
  end

  get "/recipes/new" do
    erb :new_recipes
  end

  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :display
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  post "/recipes" do
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end

  patch "/recipes/:id" do
    copy_params = params.dup
    copy_params.delete("_method")
    copy_params.delete("id")

    Recipe.find(params[:id]).update(copy_params)
    redirect "/recipes/#{params[:id]}"
  end

  delete "/recipes/:id" do
    Recipe.find(params[:id]).destroy
    redirect "/recipes"
  end


end
