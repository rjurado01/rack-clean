module Accounts
  module Users
    class PgRepository
      def initialize(
        connection = I::Pg::Connection.call,
        entity_klass = I::Accounts::Users::ENTITY
      )
        @connection = connection
        @entity_klass = entity_klass
      end

      def find(id)
        user = @connection.exec("SELECT id, name, email FROM users WHERE id = #{id} LIMIT 1").first

        raise NotFoundError unless user

        @entity_klass.new(user)
      end

      def list(_params)
        @connection.exec('SELECT id, name, email FROM users').map { @entity_klass.new(_1) }
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
    end
  end
end
