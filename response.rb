class Response

  attr_reader :response

  def initialize(response, continue)
    @response = response.to_s
    @continue = continue
  end


  def continue?
    @continue
  end

end