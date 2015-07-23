require 'active_record'

class PGDatabase

  @@conn = ActiveRecord::Base.establish_connection(:adapter => 'postgresql',
                                                  :username => 'msl',
                                                  :password => '',
                                                  :database => 'recipes_server').connection

  def self.conn
    @@conn
  end
end
