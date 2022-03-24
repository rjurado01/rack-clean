module Accounts
  module Users
    class InviteDto < Dry::Struct
      attribute :current_user do
        attribute :id, Types::Integer
        attribute :role, Types::String
        attribute :company_id, Types::Integer
      end

      attribute :company_id, Types::Integer
      attribute :emails, Types::Array.of(Types::String)
      attribute :role, Types::String
    end
  end
end
