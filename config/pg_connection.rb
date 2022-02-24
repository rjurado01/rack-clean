require 'pg'

class PgConnection
  include Singleton

  def initialize(dbname = I::Pg::NAME, port: I::Pg::PORT, host: I::Pg::HOST)
    @connection = PG.connect(dbname:, port:, host:)
  end

  def exec(query)
    @connection.exec(query)
  end
end
