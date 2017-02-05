# Class which parses SQL SELECT statements
class Select
  def self.parse(statement)
    table = get_table(statement)
    columns = get_columns(statement)
    criterion = get_criterion(statement)
    { table_name: table, columns: columns, criterion: criterion }
  end

  private

  def self.get_table(statement)
    table = (/(?<=FROM)\s(?'table'\w+).+/.match statement)[:table]
    table
  end

  def self.get_columns(statement)
    columns = (/(?<=SELECT)\s(?'columns'.+)\s(?=FROM)/.match statement)[:columns]
    columns = columns.split(', ').map(&:to_sym)
    columns
  end

  def self.get_criterion(statement)
    criterion = /(?<=WHERE)\s(.+);/.match statement
    return {} unless criterion
    criterion = criterion[1]
    criterion = criterion.split(" = ")
    criterion[0] = criterion[0].to_sym
    Hash[*criterion]
  end
end
