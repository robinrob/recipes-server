require 'csv'

load 'question.rb'

MULTI_ANSWER_DELIMITER = "-"

class Database

  $stdout, $stderr = STDOUT, STDERR

  MULTI_ANSWER_DELIMITER = "-"

  QUESTION_COL = "question"

  ANSWER_COL = "answer"

  MARKED_COL = "marked"

  SCORE_COL = "score"


  def initialize(filename)

    @filename = filename
    @data = nil
    @headers = nil

  end


  def read_all()
    @data = []

    CSV.foreach(@filename, :headers => true) do |csv_obj|

      if (csv_obj[MARKED_COL] == "true")
        marked = true
      else
        marked = false
      end

      @headers = csv_obj.headers
      @data << Question.new(question=csv_obj[QUESTION_COL],
                          answer=csv_obj[ANSWER_COL].split(MULTI_ANSWER_DELIMITER),
                          marked=marked,
                          score=csv_obj[SCORE_COL])

    end

    @data

  end


  def write_raw(raw_data)

    open(@filename, mode = "wb", options = Hash.new ) do |csv|

      raw_data.each { |record| csv << record }

    end

  end


  def write_all(filename=@filename)

    open(filename, mode = "wb", options = Hash.new ) do |csv|

      csv << @headers.join(",") + "\n"
      @data.each { |record| csv << record.to_csv }

    end

  end


  def find(question)
    result = Array.new()

    @data.each do |record|
      if record.question == question
        result << record
      end
    end

    result

  end


  def mark(question)

    result = find(question)

    result.each do |record|
      record.marked = true
    end

  end


  def print()
    @data.each {|record| puts record.to_csv}
  end

end
