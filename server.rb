require 'JSON'
require 'sinatra'
require 'sinatra/cross_origin'

load 'recipe.rb'

configure do
  enable :cross_origin
end

# list all
get '/recipes' do
  Recipe.all.to_json
end

# view one
get '/recipes/:id' do
  record = Recipe.find(params[:id])
  return status 404 if recipe.nil?
  recipe.to_json
end

# create
post '/recipes' do
  recipe = Recipe.new(params['recipe'])
  recipe.save
  status 201
end

# update
put '/recipes/:id' do
  recipe = Recipe.find(params[:id])
  return status 404 if recipe.nil?
  recipe.update(params[:recipe])
  recipe.save
  status 202
end

delete '/recipes/:id' do
  recipe = Recipe.find(params[:id])
  return status 404 if recipe.nil?
  recipe.delete
  status 202
end