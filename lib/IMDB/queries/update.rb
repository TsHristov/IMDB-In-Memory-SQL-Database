# Class which parses SQL UPDATE statements
class Update
  # Parses the whole SQL statement
  # @param statement [String] the SQL statement
  # @return [Hash] hash with the data extracted from the SQL statement - table`s name, field, value, criterion for the update
  def self.parse(statement)
    table = get_table(statement)
    field = get_field(statement)
    value = get_value(statement)
    criterion = get_criterion(statement)
    {
      table_name: table,
      field: field,
      value: value,
      criterion: criterion
    }
  end

  private

  # Gets the table name from the SQL statement
  # @param statement [String] the SQL statement
  # @return [String] the name of the table
  def self.get_table(statement)
    table = (/(?<=^UPDATE)\s(?'table'\w+)/.match statement)[:table]
    table
  end

  # Gets the field to be updated from the SQL statement
  # @param statement [String] the SQL statement
  # @return [Symbol] the field to be updated
  # @example
  #         statement = "UPDATE students SET name = 'STUDENT NAME' WHERE id = 1;"
  #         => field = :name
  # @todo add support for more than one field
  def self.get_field(statement)
    field = (/(?<=SET)\s((?'field'\w+).+)\s(?=WHERE)/.match statement)[:field]
    field.to_sym
  end

  # Gets the new value to be updated from the SQL statement
  # @param statement [String] the SQL statement
  # @return [String] the new value
  # @example
  #         statement = "UPDATE students SET name = 'STUDENT NAME' WHERE id = 1;"
  #         => value = "'STUDENT NAME'"
  def self.get_value(statement)
    value = (/(?<=SET)\s(.+=\s(?'value'.+))\s(?=WHERE)/.match statement)[:value]
    value
  end

  # Gets the update criterion from the SQL statement
  # @param statement [String] the SQL statement
  # @return [Hash] the criterion
  # @example
  #         statement = "UPDATE students SET name = 'STUDENT NAME' WHERE id = 1;"
  #         => criterion = { id: "1" }
  def self.get_criterion(statement)
    criterion = (/(?<=WHERE)\s(?'criterion'\w+.+);$/.match statement)[:criterion]
    criterion = criterion.split(' = ')
    criterion[0] = criterion[0].to_sym
    Hash[*criterion]
  end
end
