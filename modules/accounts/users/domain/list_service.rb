module Accounts
  module Users
    class ListService
      def initialize(repository = I::Accounts::Users::Repository.call)
        @repository = repository
      end

      def run(dto)
        @repository.list(
          (dto.filters || {}).merge(company_id: dto.company_id),
          dto.order,
          dto.page
        )
      end
    end
  end
end
