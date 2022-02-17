module Accounts
  module Users
    class SequelRepository
      def initialize(
        connection = I::Sequel::Connection.call,
        entity_klass = I::Accounts::Users::ENTITY
      )
        @connection = connection
        @entity_klass = entity_klass
      end

      def find(id)
        user = base_query.where(users[:id] => id).first

        @entity_klass.new(user)
      end

      def list(filters, _order, _page)
        query = base_query

        query = query.where(users[:company_id] => filters[:company_id]) if filters[:company_id]

        query.map { @entity_klass.new(_1) }
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

      private

      def users
        Sequel[:users]
      end

      def roles
        Sequel[:roles]
      end

      def base_query
        @connection
          .from(:users)
          .select(
            users[:id],
            users[:name],
            users[:email],
            users[:created_at],
            users[:updated_at],
            users[:company_id],
            roles[:name].as(:role)
          )
          .join(:roles, id: :role_id)
      end
    end
  end
end
