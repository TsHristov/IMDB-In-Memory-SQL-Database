require 'IMDB/table/table'
require 'IMDB/table/data_record'

# Class, which takes data parsed from a SQL statement and executes it.
class QueriesManager
  # Creates a table in the database
  # @param data [Hash] parsed data
  def self.create_table(data)
    table_name, columns = data[:table_name], data[:columns]
    Table.create(table_name, columns)
  end

  # Inserts data in a table
  # @param data [Hash] parsed data
  def self.insert(data)
    table_name, columns, values = data[:table_name], data[:columns], data[:values]
    table  = Database.find_table(table_name)
    record = DataRecord.new(columns, values)
    table.insert(record)
  end

  # Updates data in a table
  # @param data [Hash] parsed data
  def self.update(data)
    table_name, field, value, criterion = data[:table_name], data[:field], data[:value], data[:criterion]
    table = Database.find_table(table_name)
    table.update(field, value, criterion)
  end

  # Selects data from a table
  # @param data [Hash] parsed data
  def self.retrieve(data)
    table_name, columns, criterion = data[:table_name], data[:columns], data[:criterion]
    table = Database.find_table(table_name)
    table.retrieve(columns, criterion)
  end

  # Deletes data from a table
  # @param data [Hash] parsed data
  def self.delete(data)
    table_name, criterion = data[:table_name], data[:criterion]
    table   = Database.find_table(table_name)
    records = table.find(criterion)
    table.delete(records)
  end
end
