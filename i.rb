module I
  module Db
    NAME = 'rack_clean'.freeze
    HOST = 'localhost'.freeze
    PORT = 5432

    # Connection = -> { ::PgConnection.instance }
    Connection = -> { ::SequelConnection.instance }
  end

  module Global
    ListDtoMapper = -> { ::Global::ListDtoMapper.new }
    Authenticate = -> { ::Global::Authenticate.new }
    ValidateError = -> { ::ValidateError }
  end

  module Accounts
    module Users
      ENTITY = ::Accounts::Users::Entity

      InviteService = -> { ::Accounts::Users::InviteService.new }
      InviteDto = -> { ::Accounts::Users::InviteDto }

      ListService = -> { ::Accounts::Users::ListService.new }

      Repository = -> { ::Accounts::Users::SequelRepository.new }
      Policy = -> { ::Accounts::Users::Policy }
      # Repository = -> { ::UserInMemoryRepository.instance }
    end
  end
end

I.freeze
