require 'singleton'

class UserInMemoryRepository
  def initialize(database = I::InMemoryDb.call)
    @database = database
  end

  def create(entity)
    @database.create(entity)
  end

  def list(_params)
    @databaase.list(:users)
  end
end
