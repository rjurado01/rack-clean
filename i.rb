module I
  module Pg
    NAME = 'meka_erp_development'.freeze
    HOST = 'localhost'.freeze
    PORT = 5432

    # Si no se llama no tiene sentido crear la conexión
    Connection = -> { ::PgConnection.instance }
    # CONNECTION = PG.connect(dbname: NAME, port: PORT, host: HOST)
  end

  module User
    ENTITY = UserEntity
    # Repository = -> { ::UserInMemoryRepository.instance }
    Repository = -> { ::Accounts::UserPgRepository.new }
  end
end

I.freeze
