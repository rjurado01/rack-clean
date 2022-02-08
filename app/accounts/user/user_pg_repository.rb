module Accounts
  class UserPgRepository
    def initialize(connection = I::Pg::Connection.call, entity_klass = I::User::ENTITY)
      @connection = connection
      @entity_klass = entity_klass
    end

    def create(entity)
      fields = []
      values = []

      entity.each_pair do |name, value|
        next unless value

        fields.push(name)
        values.push(value)
      end

      fields = fields.join(',')
      values = values.map { "'#{_1}'" }.join(',')

      @connection.exec("INSERT INTO users (#{fields}) VALUES (#{values})")
    end

    def list(_params)
      @connection.exec('SELECT name, email FROM users').map { @entity_klass.new(_1) }
    end
  end
end
