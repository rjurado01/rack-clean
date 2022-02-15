module I
  module Pg
    NAME = 'meka_erp_development'.freeze
    HOST = 'localhost'.freeze
    PORT = 5432

    # Si no se llama no tiene sentido crear la conexión
    Connection = -> { ::PgConnection.instance }
    # CONNECTION = PG.connect(dbname: NAME, port: PORT, host: HOST)
  end

  module Sequel
    Connection = lambda {
      ::Sequel.connect('postgres://rjurado@localhost:5432/meka_erp_development')
    }
  end

  module Global
    ListDtoMapper = -> { ::Global::ListDtoMapper.new }
    Authenticate = -> { ::Global::Authenticate.new }
  end

  module Accounts
    module Users
      ENTITY = ::Accounts::Users::Entity

      ListService = -> { ::Accounts::Users::ListService.new }
      Repository = -> { ::Accounts::Users::SequelRepository.new }
      Policy = -> { ::Accounts::Users::Policy }
      Representation = -> { ::Accounts::Users::Representation }
      # Repository = -> { ::UserInMemoryRepository.instance }
    end
  end
end

I.freeze
