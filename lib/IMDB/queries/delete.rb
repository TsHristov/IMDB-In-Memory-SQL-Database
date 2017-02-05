# Class which parses SQL DELETE statements
class Delete
  # Parses the whole SQL statement
  # @param statement [String] the SQL statement
  # @return [Hash] hash with the data extracted from the SQL statement - table`s name and deletion criterion
  def self.parse(statement)
    table = get_table(statement)
    criterion = get_criterion(statement)
    { table_name: table, criterion: criterion }
  end

  private
  
  # Gets the table name from the SQL statement
  # @param statement [String] the SQL statement
  # @return [String] the name of the table
  def self.get_table(statement)
    table = (/(?<=DELETE FROM)\s(?'table'\w+)\s(?=WHERE)/.match statement)[:table]
    table
  end

  # Gets the criterion for the deletion
  # @param statement [String] the SQL statement
  # @return [Hash] the deletion criterion
  # @example
  #         statement = "DELETE FROM students WHERE id = 1;"
  #         => criterion = { id: "1" }
  def self.get_criterion(statement)
    criterion = (/(?<=WHERE)\s(?'criterion'.+);/.match statement)[:criterion]
    criterion = criterion.split(" = ")
    criterion[0] = criterion[0].to_sym
    Hash[*criterion]
  end
end
