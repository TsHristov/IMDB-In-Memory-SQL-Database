# Class which parses SQL INSERT statements
class Insert
  # Parses the whole SQL statement
  # @param statement [String] the SQL statement
  # @return [Hash] hash with the data extracted from the SQL statement - table`s name, columns and values
  def self.parse(statement)
    table   = get_table(statement)
    columns = get_columns(statement)
    values  = get_values(statement)
    { table_name: table, columns: columns, values: values }
  end

  private

  # Gets the table name from the SQL statement
  # @param statement [String] the SQL statement
  # @return [String] the name of the table
  def self.get_table(statement)
    table = (/(?<=^INSERT INTO)\s(?'table'\w+)/.match statement)[:table]
    table
  end

  # Gets the table columns from the SQL statement
  # @param statement [String] the SQL statement
  # @return [Array<Symbol>] an array of the columns (represented as symbols)
  # @example
  #         statement = "INSERT INTO students (id, name) VALUES (1, 'FirstName');"
  #         => columns = [:id. :name]
  def self.get_columns(statement)
    columns = /\((.+)\) /.match statement
    columns = columns[1].split(', ')
    columns.map(&:to_sym)
  end

  # Gets the columns` values from the SQL statement
  # @param statement [String] the SQL statement
  # @return [Array<String>] the columns` values
  # @example
  #        statement = "INSERT INTO students (id, name) VALUES (1, 'FirstName');"
  #        => values = ["1", "'FirstName'"]
  def self.get_values(statement)
    values = /(?<=VALUES)\s\((.+)\);/.match statement
    values = values[1].split(', ')
    values
  end
end
