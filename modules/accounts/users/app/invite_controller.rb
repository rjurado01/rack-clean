module Accounts
  module Users
    class InviteController
      Schema = Dry::Schema.Params do
        required(:data).hash do
          required(:company_id).filled(:integer)
          required(:emails).array(:str?)
          required(:role).filled(:string)
        end
      end

      def initialize(
        authenticate = I::Global::Authenticate.call,
        dto_klass = I::Accounts::Users::InviteDto.call,
        policy = I::Accounts::Users::Policy.call,
        service = I::Accounts::Users::InviteService.call
      )
        @authenticate = authenticate
        @dto_klass = dto_klass
        @policy = policy
        @service = service
      end

      def run(req)
        current_user = @authenticate.run(req)
        dto = build_dto(current_user, req)
        @policy.invite(dto)
        @service.run(dto)

        [204, {}, {}]
      end

      private

      def build_dto(current_user, req)
        schema = Schema.call(JSON.parse(req.body.read))

        raise(ValidateError, schema.errors.to_h) if schema.failure?

        @dto_klass.new(
          schema.output[:data].merge(current_user: current_user)
        )
      end
    end
  end
end
