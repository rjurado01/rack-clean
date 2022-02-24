module I
  module Db
    NAME = 'meka_erp_development'.freeze
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
      Representation = -> { ::Accounts::Users::Representation }
      # Repository = -> { ::UserInMemoryRepository.instance }
    end
  end
end

I.freeze
