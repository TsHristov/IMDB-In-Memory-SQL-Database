# Class which parses SQL INSERT statements
class Insert
  def self.parse(statement)
    table   = get_table(statement)
    columns = get_columns(statement)
    values  = get_values(statement)
    { table_name: table, columns: columns, values: values }
  end

  private

  def self.get_table(statement)
    table = (/(?<=^INSERT INTO)\s(?'table'\w+)/.match statement)[:table]
    table
  end

  def self.get_columns(statement)
    columns = /\((.+)\) /.match statement
    columns = columns[1].split(', ')
    columns
  end

  def self.get_values(statement)
    values = /(?<=VALUES)\s\((.+)\);/.match statement
    values = values[1].split(', ')
    values
  end
end
