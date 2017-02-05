# Class which parses SQL SELECT statements
class Select
  # Parses the whole SQL statement
  # @param statement [String] the SQL statement
  # @return [Hash] hash with the data extracted from the SQL statement - table`s name, columns and criterion
  def self.parse(statement)
    table = get_table(statement)
    columns = get_columns(statement)
    criterion = get_criterion(statement)
    { table_name: table, columns: columns, criterion: criterion }
  end

  private

  # Gets the table name from the SQL statement
  # @param statement [String] the SQL statement
  # @return [String] the name of the table
  def self.get_table(statement)
    table = (/(?<=FROM)\s(?'table'\w+).+/.match statement)[:table]
    table
  end

  # Gets the columns to be selected from the SQL statement
  # @param statement [String] the SQL statement
  # @return [Array<Symbol>] the table`s columns to be selected
  # @example
  #         statement = "SELECT id, name FROM students;"
  #         => columns = [:id, :name]
  def self.get_columns(statement)
    columns = (/(?<=SELECT)\s(?'columns'.+)\s(?=FROM)/.match statement)[:columns]
    columns = columns.split(', ')
    columns.map(&:to_sym)
  end

  # Gets the selection criterion from the SQL statement
  # @param statement [String] the SQL statement
  # @return [Hash] the selection criterion
  # @example
  #        statement = "SELECT id, name FROM students WHERE id = 1;"
  #        => criterion = { id: "1" }
  def self.get_criterion(statement)
    criterion = /(?<=WHERE)\s(.+);/.match statement
    return {} unless criterion
    criterion = criterion[1]
    criterion = criterion.split(" = ")
    criterion[0] = criterion[0].to_sym
    Hash[*criterion]
  end
end
