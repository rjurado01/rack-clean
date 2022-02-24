module Global
  class DtoBuilder
    def initialize(dto_klass, schema, validate_error = I::Global::ValidateError.call)
      @dto_klass = dto_klass
      @schema = schema
      @validate_error = validate_error
    end

    def run(current_user, req)
      schema = @schema.call(JSON.parse(req.body.read))

      raise(@validate_error, schema.errors.to_h) if schema.failure?

      @dto_klass.new(
        schema.output[:data].merge(current_user: current_user)
      )
    end
  end
end
