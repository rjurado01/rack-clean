module Accounts
  module Users
    class ListService
      def initialize(repository = I::Accounts::Users::Repository.call)
        @repository = repository
      end

      def run(params = {})
        @repository.list(params)
      end
    end
  end
end
