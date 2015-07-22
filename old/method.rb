$LOAD_PATH << '.'

require 'json'

def Method
  # String
  attr_accessor :description
  # Array of strings
  attr_accessor :steps

  def initialize(description=nil, steps=[])
    @description = description
    @steps = steps
  end

  def to_json
    { :description => @description, :steps => @steps }.to_json
  end
end