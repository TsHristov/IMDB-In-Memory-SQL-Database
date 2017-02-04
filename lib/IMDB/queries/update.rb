class Update
  def self.parse(statement)
    table = get_table(statement)
    field = get_field(statement)
    value = get_value(statement)
    query = get_query(statement)
    {
      table_name: table,
      field: field,
      value: value,
      query: query
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

  def self.get_query(statement)
    query = (/(?<=WHERE)\s(?'query'\w+.+);$/.match statement)[:query]
    query = query.split(' = ')
    query[0] = query[0].to_sym
    Hash[*query]
  end
end
