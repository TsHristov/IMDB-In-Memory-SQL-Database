# Class which represents a row (data record) from a table in the database.
class DataRecord
  attr_reader :columns, :values
  
  # Creates new DataRecord object
  # @param columns [Array] symbols, which represent the table columns
  # @param values [Array]  values, with which to be initialized the DataRecord object
  # @example
  #         columns = [:id, :name]
  #         values  = ["1", "'FirstName'"]
  #         Will create DataRecord object with values = {id: "1", name: "'FirstName'"}
  def initialize(columns, values)
    @columns = columns.map { |column| column.to_sym }
    @values  = @columns.zip(values).each.to_h
    self.class.define_methods(@columns, @values)
  end

  # Defines setters and getters for the record`s fields
  # @param columns [Array] symbols, which represent the table columns
  # @param values [Array]  values, with which to be initialized the DataRecord object
  # @example
  #        column = [:id, :name]
  #        Will generate instance methods: :id, :id=, :name, :name=
  def self.define_methods(columns, values)
    columns.each do |column|
      define_method(column) { values[column] }
      define_method("#{column}=") do |value|
        values[column] = value
      end
    end
  end

  # Checks whether the DataRecord object has key, value pair corresponding to query
  # @param query[Hash]
  # @return [true] when the query is the empty hash (meaning all columns should be matched)
  # @return [true] when there is key, value pair that matches query
  # @example
  #        record = #<DataRecord:0x005603678cc380 @columns=[:id, :name], @values={:id=>"1", :name=>"'Student'"}>
  #        query  = {id: "1"}
  #        record.match_query(query) #=> true
  def match_query(query)
    return true if query == {}
    query.all? { |key, value| values[key] == value }
  end

  # Updates the record`s field with a given value
  # @param field [Symbol]
  # @param value [String]
  def update(field, value)
    send "#{field}=", value
  end

  # Checks for equality between two DataRecord objects
  # @param data_record [DataRecord]
  # @return [true, false]
  def ==(data_record)
    data_record.columns == columns &&
    data_record.values  == values
  end
end
