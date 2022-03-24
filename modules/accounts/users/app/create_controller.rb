module Accounts
  module Users
    class CreateController
      def new(
        authenticate = I::Global::Authenticate.call,
        dto_klass = I::Users::CREATE_DTO,
        policy = I::Users::Policy.call,
        service = I::Users::CreateService.call,
        representation = I::Users::REPRESENTATION
      )
        @odt_builder = odt_builder
        @policy = policy
        @service = service
        @representation = representation
      end

      def run(req)
        current_user = @authenticate.run(req)
        params = JSON.parse(req.body.read, symbolize_names: true)
        odt = @dto_klass.new(current_user, req).run

        @policy.new(odt).run

        user = Accounts::CreateUserService.new.run(odt)
        response = @representation.create(user).run

        [201, {'Content-Type' => 'application/json'}, response]
      end
    end
  end
end
