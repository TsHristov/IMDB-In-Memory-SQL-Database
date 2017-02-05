require 'IMDB/table/data_record'

# Module to perform CRUD(Create, Read, Update, Delete) operations
module CRUD
  module ClassMethods
    # Creates a new table in the Database
    # @param table_name [String] table`s name
    # @param columns [Hash] table`s columns
    def create(table_name, columns)
      table = Table.new table_name, columns
      Database.create_table(table)
    end
  end

 # Inserts a DataRecord into the table
 # @param record [DataRecord] the record to be inserted
  def insert(record)
    @data << record
  end

  # Updates records`s fields, if records match query
  # @param field [Symbol] the record`s field to be updated
  # @param value [String] the new value, which is to be set
  # @param query [Hash] condition which filters the records to be updated
  def update(field, value, query)
    records = find(query)
    records.each { |record| record.send "#{field}=", value }
  end

  # Retrieves data from the table
  # -
  def retrieve(columns=[], query)
    records = find(query)
    result = []
    records.each do |record|
      result << record.values.select { |key, value| columns.include? key }
    end
    result
  end

  # Deletes records from the table
  # @param records [Array<DataRecords>] the records to be deleted
  def delete(records)
      Array(records).each { |record| @data.delete(record) }
  end

  private

  def self.included(base)
    base.extend ClassMethods
  end
end

# @attr_reader name [String] table`s name
# @attr_reader columns [Hash] table`s columns
# @attr_reader data [Array] table`s data
class Table
  include CRUD
  attr_reader :name, :columns, :data

  # Creates new Table object
  # @param name [String] table`s name
  # @param columns [Hash] table`s columns
  # @example
  #        columns = {:id=>{:type=>Fixnum, :null=>false}, :name=>{:type=>String, :null=>false}}
  def initialize(name, columns)
    @name    = name
    @columns = columns
    @data    = []
  end

  # Finds all records matching query
  # @param query[Hash]
  # @return [Array<DataRecord>, Array] all found DataRecords or an empty array if none found
  def find(query)
    @data.select { |record| record.match_query(query) }
  end

  # Checks for equality between two Table objects
  # @param table[Table]
  # @return [true, false]
  def ==(table)
    table.name    == name &&
    table.columns == columns &&
    table.data    == data
  end

end
