$LOAD_PATH << '.'

require 'json'

class Recipe

  attr_reader :id
  # String
  attr_reader :name
  # String
  attr_reader :origin
  # Array of Ingredient
  attr_reader :ingredients
  # Method
  attr_reader :method

  @conn = PGDatabase.conn()


  def initialize(id=nil, name=nil, origin=nil, ingredients=[], method=nil)
    @id = id
    @name = name
    @origin = origin
    @ingredients = ingredients
    @method = method
    @inserted = false
  end


  def to_json
    ingredients = []
    @ingredients.each do |ingredient|
      ingredients << ingredient.to_json
    end
    { :id => @id, :name => @name, :origin => @origin, :ingredients => [ingredients], :method => @method.to_json}.to_json
  end

  def new_from_row(row)
    records << Question.new(id=row[0],
                            name=row[1],
                            origin=row[2],
                            ingredients=row[3],
                            method=row[4])
  end

  def self.all()
    rows = @conn.query('select * from recipes')

    records = []
    rows.each do |row|
      ingredients = []
      row[3].each do |id|
        ingredients << Ingredient.find()
      end
      records << new_from_row(row)
    end

    records
  end


  def save()
    if !@inserted
      _insert
    else
      _update
    end
  end


  def _insert()
    question = record.question.gsub(/'/){ "''" }
    answers = record.answers.join(MULTI_ANSWER_DELIMITER).


        values = "values (\'#{question}\',\'#{answers}\',\'#{record.marked}\',\'#{record.score}\')"
    query = "insert into questions (question,answers,marked,score) #{values};"

    @conn.query(query)
  end


  def _update()
    @conn.query("UPDATE questions SET question='#{@question}', answers='#{@answers}', marked=#{marked}, score=#{score} WHERE id = #{@id};")
  end

end
