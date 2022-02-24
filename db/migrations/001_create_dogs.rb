Sequel.migration do
  change do
    create_table(:dogs) do
      String :name, null: false
      String :email, unique: true, null: false
      DateTime :created_at
      DateTime :updated_at

      primary_key :id
      foreign_key :company_id, :companies
    end
  end
end
