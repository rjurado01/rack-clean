module Accounts
  module Users
    class ListService
      def initialize(repository = I::Accounts::Users::Repository.call)
        @repository = repository
      end

      def run(dto)
        @repository.list_by_company(
          dto.company_id,
          dto.filters,
          dto.order,
          dto.page
        )
      end
    end
  end
end
