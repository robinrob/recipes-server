#!/usr/bin/env ruby

require 'JSON'
require 'sinatra'
require 'sinatra/cross_origin'

load 'recipe.rb'

before do
  content_type :json
end

configure do
  enable :cross_origin
end

url = 'http://localhost:3000'

set :allow_origin, url
set :allow_methods, [:get, :post, :put]


# list all
get '/recipes' do
  cross_origin :allow_origin => url,
               :allow_methods => [:get]

  Recipe.all.to_json
end

# view one
get '/recipes/:id' do
  puts "GET /recipes/:id"
  cross_origin :allow_origin => url,
               :allow_methods => [:get]

  recipe = Recipe.find(params[:id])
  return status 404 if recipe.nil?
  recipe.to_json
end

# create
post '/recipes' do
  cross_origin :allow_origin => url,
               :allow_methods => [:post]

  data = JSON.parse request.body.read
  Recipe.new(data[:recipe]).save
  status 201
end

# update
put '/recipes/:id' do
  cross_origin :allow_origin => url,
               :allow_methods => [:put]

  puts 'PUT /recipes/:id'

  recipe = Recipe.find(params[:id])
  return status 404 if recipe.nil?
  data = JSON.parse request.body.read
  recipe.update(data['recipe'])
  status 200
end

delete '/recipes/:id' do
  recipe = Recipe.find(params[:id])
  return status 404 if recipe.nil?
  recipe.delete
  status 202
end
