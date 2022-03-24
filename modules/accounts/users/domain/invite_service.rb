module Accounts
  module Users
    class InviteService
      attr_reader :errors

      def initialize(
        repository = I::Accounts::Users::Repository.call,
        entity_klass = I::Accounts::Users::ENTITY,
        validate_error_klass = I::Global::ValidateError.call # esto también se le pasa aqui ?
      )
        @repository = repository
        @entity_klass = entity_klass
        @validate_error_klass = validate_error_klass
        @errors = {}
        @entity = nil
      end

      def run(dto)
        items = dto.emails.map do |email|
          {
            unconfirmed_email: email,
            role_id: dto.role_id,
            created_at: Time.now,
            updated_at: Time.now
          }
        end

        raise(@validate_error_klass, @errors) unless validate(items)

        @repository.bulk_invite(items)

        true
      end

      private

      def validate(items)
        # add_error(:email, {error: :blank}) unless entity.email
        # @errors.empty?
        true
      end

      def add_error(field, error)
        @errors[field] ||= []
        @errors[field].push error
      end
    end
  end
end
