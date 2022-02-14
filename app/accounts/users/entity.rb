module Accounts
  module Users
    Entity = Struct.new(
      :id,
      :name,
      :email,
      :created_at,
      :updated_at,
      :company_id,
      keyword_init: true
    )
  end
end
