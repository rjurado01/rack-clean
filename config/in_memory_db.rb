class InMemoryDb
  include Singleton

  def initialize
    @db = {}
  end

  def create(table, entity)
    @db[table] ||= []
    @db[table].push(entity)
  end

  def list(table)
    @db[table]
  end
end
