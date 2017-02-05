class DataRecord
  attr_reader :columns, :values

  def initialize(columns, values)
    @columns = columns.map { |column| column.to_sym }
    @values  = @columns.zip(values).each.to_h
    self.class.define_methods(@columns, @values)
  end

  def self.define_methods(columns, values)
    columns.each do |column|
      define_method(column) { values[column] }
      define_method("#{column}=") do |value|
        values[column] = value
      end
    end
  end

  def match_query(query)
    return true if query == {}
    values.one? { |key, value| query[key] == value }
  end

  def update(field, value)
    send "#{field}=", value
  end

  def ==(data_record)
    data_record.columns == columns &&
    data_record.values  == values
  end
end
