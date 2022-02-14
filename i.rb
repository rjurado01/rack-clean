module I
  module Pg
    NAME = 'meka_erp_development'.freeze
    HOST = 'localhost'.freeze
    PORT = 5432

    # Si no se llama no tiene sentido crear la conexión
    Connection = -> { ::PgConnection.instance }
    # CONNECTION = PG.connect(dbname: NAME, port: PORT, host: HOST)
  end

  module Global
    ListDtoMapper = -> { ::Global::ListDtoMapper.new }
    Authenticate = -> { ::Global::Authenticate.new }
  end

  module Accounts
    module Users
      ENTITY = ::Accounts::Users::Entity
      POLICY = ::Accounts::Users::Policy
      REPRESENTATION = ::Accounts::Users::Representation

      ListService = -> { ::Accounts::Users::ListService.new }
      Repository = -> { ::Accounts::Users::PgRepository.new }
      # Repository = -> { ::UserInMemoryRepository.instance }
    end
  end
end

I.freeze
