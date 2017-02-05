# Class which parses SQL DELETE statements
class Delete
  def self.parse(statement)
    table = get_table(statement)
    criterion = get_criterion(statement)
    { table_name: table, criterion: criterion }
  end

  def self.get_table(statement)
    table = (/(?<=DELETE FROM)\s(?'table'\w+)\s(?=WHERE)/.match statement)[:table]
    table
  end

  def self.get_criterion(statement)
    criterion = (/(?<=WHERE)\s(?'criterion'.+);/.match statement)[:criterion]
    criterion = criterion.split(" = ")
    criterion[0] = criterion[0].to_sym
    Hash[*criterion]
  end
end
