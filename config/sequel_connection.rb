class SequelConnection
  include Singleton

  def initialize(dbname = I::Db::NAME, port: I::Db::PORT, host: I::Db::HOST)
    Sequel.connect("postgres://rjurado@#{host}:#{port}/postgres") do |db|
      if db.execute("SELECT 1 FROM pg_database WHERE datname = '#{dbname}'").zero?
        db.execute "CREATE DATABASE #{dbname}"
      end
    end

    @connection = Sequel.connect("postgres://rjurado@#{host}:#{port}/#{dbname}")

    Sequel.extension :migration

    unless Sequel::Migrator.is_current?(@connection, 'db/migrations')
      Sequel::Migrator.run(@connection, 'db/migrations')
    end
  end

  def from(table)
    @connection.from(table)
  end

  def method_missing(method, *args, &block)
    @connection.public_send(method, *args, &block)
  end

  def respond_to_missing?(name, include_private = false)
    @connection.respond_to?(name, include_private)
  end
end
