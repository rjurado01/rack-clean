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
        user = @connection.from(:users)
                 .select(:id, :name, :email, :company_id)
                 .where(id: id)
                 .first

        @entity_klass.new(user)
      end

      def find_with_role(id)
        users = Sequel[:users]
        roles = Sequel[:roles]

        user = @connection.from(:users)
                 .select(
                   users[:id],
                   users[:name],
                   users[:email],
                   users[:company_id],
                   roles[:name].as(:role)
                 )
                 .join(:roles, id: :role_id)
                 .where(users[:id] => id)
                 .first

        @entity_klass.new(user)
      end

      def list(_params)
        @connection
          .from(:users)
          .select(:id, :name, :email, :company_id)
          .map { @entity_klass.new(_1) }
      end

      def list_by_company(company_id, _filters, _order, _page)
        @connection
          .from(:users)
          .select(:id, :name, :email, :company_id)
          .where(company_id: company_id)
          .map { @entity_klass.new(_1) }
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
