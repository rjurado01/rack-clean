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

      def invite(dto)
        return if
          dto.current_user &&
          dto.current_user.company_id === dto.company_id &&
          dto.current_user.role == 'Administrador'

        raise UnauthorizedError
      end
    end
  end
end
