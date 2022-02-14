module Accounts
  module Users
    module Representation
      module_function

      def list(user_entities)
        user_entities.map { |user|
          {name: user.name, email: user.email}
        }.to_json
      end
    end
  end
end
