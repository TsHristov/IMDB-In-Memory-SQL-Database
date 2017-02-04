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


  def insert(columns, values)
    record = DataRecord.new(columns, values)
    @data << record
  end

  # DOES NOT WORK PROPERLY!
  # !!!!!!!!!!!!!!!!!!!!!!
  def update(field, value, query)
    records = find(query)
    print records
    records.each { |record| record.send "#{field}=", value }
    print find(query)
  end

  def retrieve(columns=[], query)
    records = find(query)
    result = []
    records.each do |record|
      result << record.values.select { |key, value| columns.include? key }
    end
    result
  end

  def delete(records)
    records.each { |record| @data.delete(record) }
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

end
