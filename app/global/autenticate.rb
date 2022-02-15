module Global
  class Authenticate
    def initialize(user_repository = I::Accounts::Users::Repository.call)
      @user_repository = user_repository
    end

    def run(_req)
      # TODO cargar el usuario del jwt
      @user_repository.find_with_role(1)
    end
  end
end
