require 'IMDB/table/table'

class QueriesManager
  def self.create_table(data)
    table_name, columns = data[:table_name], data[:columns]
    Table.create(table_name, columns)
  end

  def self.insert(data)
    table_name, columns, values = data[:table_name], data[:columns], data[:values]
    table = Database.find_table(table_name)
    table.insert(columns, values)
  end

  def self.update(data)
    table_name, field, value, query = data[:table_name], data[:field], data[:value], data[:query]
    table = Database.find_table(table_name)
    table.update(field, value, query)
  end

  def self.retrieve(data)
    table_name, columns, criterion = data[:table_name], data[:columns], data[:criterion]
    table = Database.find_table(table_name)
    table.retrieve(columns, criterion)
  end

  def self.delete(data)
    table_name, criterion = data[:table_name], data[:criterion]
    table   = Database.find_table(table_name)
    records = table.find(criterion)
    table.delete(records)
  end
end
