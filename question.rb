$LOAD_PATH << '.'

class Question

  attr_reader :id
  attr_reader :question
  attr_reader :answers
  attr_accessor :marked
  attr_accessor :score

  @conn = PGDatabase.conn()


  def initialize(id=nil, question=nil, answers=nil, marked=false, score=0)
    @id = id
    @question = question
    @answers = answers
    @marked = marked
    @score = score.to_i
    @inserted = false
  end


  def to_csv
    "" + [@id,@question,@answers,@marked,@score].join(",") + "\n"
  end


  def self.all()
    rows = @conn.query('select * from questions')

    records = []
    rows.each do |row|
      records << Question.new(id=row[0],
                            question=row[1],
                            answers=row[2],
                            marked=row[3],
                            score=row[4])
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
