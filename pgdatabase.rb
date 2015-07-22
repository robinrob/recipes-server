require 'pg'
require 'active_record'
require 'csv'

load 'recipe.rb'

class PGDatabase

  RECIPES_TABLE = 'recipes'

  ID_COL = 'id'

  QUESTION_COL = 'question'

  ANSWER_COL = 'answers'

  MARKED_COL = 'marked'

  SCORE_COL = 'score'

  MULTI_ANSWER_DELIMITER = '-'


  @@conn = ActiveRecord::Base.establish_connection(:adapter => 'postgresql',
                                                  :username => 'msl',
                                                  :password => '',
                                                  :database => 'recipes').connection

  def conn
    @@conn
  end

  self.init


  def self.init
    self.drop
    self.create
    self.populate
  end


  def self.drop
    @conn.query('drop table questions;')
  end


  def self.create
    @conn.query("CREATE TABLE #{QUESTIONS_TABLE} (
                 #{ID_COL} 			 serial PRIMARY KEY,
                 #{QUESTION_COL} varchar(100) UNIQUE NOT NULL,
                 #{ANSWERS_COL}  varchar(100) NOT NULL,
                 #{MARKED_COL}   boolean NOT NULL DEFAULT FALSE,
                 #{SCORE_COL}		 integer NOT NULL DEFAULT 0
                );")
  end


  def self.populate
    self.insert_all(self.read_recipes_csv)
  end


  def self.read_recipes_csv
    records = []

    CSV.foreach('recipes.csv', :headers => true) do |csv_obj|

      headers = csv_obj.headers

      records << Recipe.new(name=csv_obj['name'],
                            origin=csv_obj['origin'],
                            method=csv_obj['method'])

    end

    records
  end


  def self.insert_all(records)
    records.each do |record|
      record.save
    end
  end

end
