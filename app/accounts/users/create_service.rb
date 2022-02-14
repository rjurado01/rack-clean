module Accounts
  module Users
    class CreateService
      attr_reader :errors

      def initialize(
        repository = I::User::Repository.call,
        entity_klass = I::User::ENTITY,
        validate_error_klass = ValidateError # esto también se le pasa aqui ?
      )
        @repository = repository
        @entity_klass = entity_klass
        @validate_error_klass = validate_error_klass
        @errors = {}
        @entity = nil
      end

      def run(params = {})
        @entity = @entity_klass.new(
          {
            name: params[:name],
            email: params[:email],
            created_at: Time.now,
            updated_at: Time.now
          }
        )

        raise(@validate_error_klass, @errors) unless validate(@entity)

        @repository.create(entity)

        entity # deberiamos aqui convertir la salida del repositorio a un DTO ?
      end

      private

      def validate(entity)
        add_error(:email, {error: :blank}) unless entity.email

        @errors.empty?
      end

      def add_error(field, error)
        @errors[field] ||= []
        @errors[field].push error
      end
    end
  end
end
