module Accounts
  module Users
    class Entity < Dry::Struct
      attribute :id, Types::Integer
      attribute :name, Types::String
      attribute :email, Types::String
      attribute :role, Types::String
      attribute :created_at, Types::Time.optional
      attribute :updated_at, Types::Time.optional
      attribute :company_id, Types::Integer
    end
  end
end
