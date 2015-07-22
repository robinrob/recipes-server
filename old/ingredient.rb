$LOAD_PATH << '.'

require 'json'

load 'pgdatabase.rb'

class Ingredient
    attr_reader :id
    # String
    attr_reader :name
    # String
    attr_reader :unit
    # Number
    attr_reader :amount

    @conn = PGDatabase.conn()

    def initialize(row)
      @id = row[1]
      @name = row[2]
      @unit = row[3]
      @amount = row[4]
    end

    def self.all()
      rows = @conn.query('select * from ingredients')

      records = []
      rows.each do |row|
        records << Ingredient.new(row)
      end

      records
    end

    def self.find(id)
      rows = @conn.query("select * from ingredients where id = #{id}")
      Ingredient.new(rows[0])
    end

    def to_json
      { :name => @name, :unit => @unit, :amount => @amount }.to_json
    end
end