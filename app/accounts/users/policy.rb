module Accounts
  module Users
    module Policy
      module_function

      def list(dto)
        return if
          dto.user_id &&
          dto.company_id &&
          dto.company_id == dto.filters['company_id'].to_i &&
          dto.user_role == 'Administrador'

        raise UnauthorizedError
      end
    end
  end
end
