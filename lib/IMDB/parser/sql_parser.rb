require 'IMDB/queries/create_table'
require 'IMDB/queries/delete'
require 'IMDB/queries/insert'
require 'IMDB/queries/select'
require 'IMDB/queries/update'
require 'IMDB/queries/queries_manager'


module SQLParser
  def parse(statement)
    case statement
    when /CREATE/
      data = CreateTable.parse(statement)
      QueriesManager.create_table(data)
    when /INSERT/
      data = Insert.parse(statement)
      QueriesManager.insert(data)
    when /UPDATE/
      data = Update.parse(statement)
      QueriesManager.update(data)
    when /SELECT/
      data = Select.parse(statement)
      QueriesManager.retrieve(data)
    when /DELETE/
      data = Delete.parse(statement)
      QueriesManager.delete(data)
    else
      raise Database::InvalidQuery.new(statement)
    end
  end
end