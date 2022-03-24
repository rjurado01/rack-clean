require 'singleton'

module Accounts
  module Users
    class InMemoryRepository
      def initialize(database = I::InMemoryDb.call)
        @database = database
      end

      def create(entity)
        @database.create(:users, entity)
      end

      def list(_params)
        @databaase.list(:users)
      end
    end
  end
end
