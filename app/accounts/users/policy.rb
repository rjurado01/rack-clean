module Accounts
  module Users
    module Policy
      module_function

      def list(_dto)
        raise UnauthorizedError unless true
      end
    end
  end
end
