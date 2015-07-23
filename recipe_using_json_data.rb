$LOAD_PATH << '.'

load 'pgdatabase.rb'

require 'json'

class Recipe < ActiveRecord::Base
  after_initialize :name, :origin, :ingredients, :method

  def as_json(options)
    super(:except => [:json_data])
  end

  def name
    self.json_data['name']
  end

  def origin
    self.json_data['origin']
  end

  def ingredients
    self.json_data['ingredients']
  end

  def method
    self.json_data['method']
  end

  def attributes
    super.merge('name' => self.name)
    super.merge('origin' => self.origin)
    super.merge('ingredients' => self.ingredients)
    super.merge('method' => self.method)
  end
end
