describe Insert do
  it 'gets the name of the table' do
    statement = "INSERT INTO students (id, name) VALUES (1, 'Student');"
    expect(Insert.get_table(statement)).to eq('students')
  end

  it 'gets the columns of the table' do
    statement = "INSERT INTO students (id, name) VALUES (1, 'Student');"
    columns = [:id, :name]
    expect(Insert.get_columns(statement)).to eq(columns)
  end

  it 'gets the values' do
    statement = "INSERT INTO students (id, name) VALUES (1, 'Student');"
    values = ["1", "'Student'"]
    expect(Insert.get_values(statement)).to eq(values)
  end

  it 'successfully parses the SQL query' do
    statement = "INSERT INTO students (id, name) VALUES (1, 'Student');"
    parsed_data = {
                   table_name: 'students',
                   columns: [:id, :name],
                   values: ["1", "'Student'"]
                  }
    expect(Insert.parse(statement)).to eq(parsed_data)
  end
end
