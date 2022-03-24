Sequel.migration do
  change do
    create_table(:invitations) do
      String :email, unique: true, null: false
      DateTime :created_at

      primary_key :id
    end
  end
end
