module Accounts
  module Users
    CreateDto = Struct.new(
      :company_id,
      :current_user_id,
      :params
    )

    class CreateDtoMapper
      def run(current_user, req)
        CreateDto.new(
          current_user.company_id,
          current_user.id,
          req.params
        )
      end
    end
  end
end
