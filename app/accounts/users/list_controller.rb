module Accounts
  module Users
    class ListController
      def initialize(
        authenticate = I::Global::Authenticate.call,
        dto_mapper = I::Global::ListDtoMapper.call,
        policy = I::Accounts::Users::Policy.call,
        service = I::Accounts::Users::ListService.call,
        representation = I::Accounts::Users::Representation.call
      )
        @authenticate = authenticate
        @dto_mapper = dto_mapper
        @policy = policy
        @service = service
        @representation = representation
      end

      def run(req)
        # añadir current_user a la req
        current_user = @authenticate.run(req)
        dto = @dto_mapper.run(current_user, req)

        @policy.list(dto)

        users = @service.run(dto)
        response = @representation.list(users)

        [200, {'Content-Type' => 'application/json'}, response]
      end
    end
  end
end
