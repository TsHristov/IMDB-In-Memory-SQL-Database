class Update
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

  def self.get_table(statement)
    table = (/(?<=^UPDATE)\s(?'table'\w+)/.match statement)[:table]
    table
  end

  def self.get_field(statement)
    field = (/(?<=SET)\s((?'field'\w+).+)\s(?=WHERE)/.match statement)[:field]
    field
  end

  def self.get_value(statement)
    value = (/(?<=SET)\s(.+=\s(?'value'.+))\s(?=WHERE)/.match statement)[:value]
    value
  end

  def self.get_criterion(statement)
    criterion = (/(?<=WHERE)\s(?'criterion'\w+.+);$/.match statement)[:criterion]
    criterion = criterion.split(' = ')
    criterion[0] = criterion[0].to_sym
    Hash[*criterion]
  end
end
