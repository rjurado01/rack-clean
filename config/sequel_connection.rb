class SequelConnection
  include Singleton

  def initialize(dbname = I::Db::NAME, port: I::Db::PORT, host: I::Db::HOST)
    @connection = Sequel.connect("postgres://rjurado@#{host}:#{port}/#{dbname}")

    Sequel.extension :migration

    unless Sequel::Migrator.is_current?(@connection, 'db/migrations')
      Sequel::Migrator.run(@connection, 'db/migrations')
    end
  end

  def from(table)
    @connection.from(table)
  end
end
