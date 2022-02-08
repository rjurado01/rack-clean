module Accounts
  class ListUsersService
    def initialize(repository = I::User::Repository.call)
      @repository = repository
    end

    def run(params = {})
      entities = @repository.list(params)

      entities.map(&:to_h)
    end
  end
end
