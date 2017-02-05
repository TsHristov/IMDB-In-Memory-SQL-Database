require 'IMDB/table/data_record'

module CRUD
  module ClassMethods
    def create(table_name, columns)
      table = Table.new table_name, columns
      Database.create_table(table)
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

 # Inserts a DataRecord into the table
 #
 # Params:
 # -record: DataRecord to be inserted
  def insert(record)
    @data << record
  end

  # Updates records`s fields, if records match query
  #
  # Params:
  # -field: the record`s field to be updated
  # -value: the new value, which is to be set
  # -query: condition which filters the records to be updated
  # Example:
  #       "UPDATE students SET name = 'FirstName' WHERE id = 1;"
  #       -field = :name
  #       -value = "'FirstName'"
  #       -query = { id: "1" }
  def update(field, value, query)
    records = find(query)
    records.each { |record| record.send "#{field}=", value }
  end

  def retrieve(columns=[], query)
    records = find(query)
    result = []
    records.each do |record|
      result << record.values.select { |key, value| columns.include? key }
    end
    result
  end

  # Deletes records from the table
  #
  # Params:
  # -records: An array of DataRecords
  def delete(records)
      Array(records).each { |record| @data.delete(record) }
  end
end

class Table
  include CRUD
  attr_reader :name, :columns, :data

  def initialize(name, columns)
    @name    = name
    @columns = columns
    @data    = []
  end

  def find(query)
    @data.select { |record| record.match_query(query) }
  end

  def ==(table)
    table.name    == name &&
    table.columns == columns &&
    table.data    == data
  end

end
