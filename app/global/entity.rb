module Global
  # Entity interface
  class Entity < Dry::Struct
    private_class_method :new

    def create(params)
      new(params)
    end

    def load(params)
      new(params)
    end

    def delete
      raise StandardError, 'not implemented'
    end
  end
end
