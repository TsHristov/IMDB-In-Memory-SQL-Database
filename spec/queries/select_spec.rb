describe Select do
  it 'gets the name of the table' do
    statement = "SELECT id, name FROM students;"
    expect(Select.get_table(statement)).to eq('students')
  end

  it 'gets the columns of the table' do
    statement = "SELECT id, name FROM students;"
    columns   = [:id, :name]
    expect(Select.get_columns(statement)).to eq(columns)
  end

  it 'gets the query criterion' do
    statement = "SELECT id, name FROM students WHERE id = 1;"
    criterion = { id: "1" }
    expect(Select.get_criterion(statement)).to eq(criterion)
  end

  it 'successfully parses the SQL query' do
    statement   = "SELECT id, name FROM students WHERE id = 1;"
    parsed_data = {
                    table_name: 'students',
                    columns: [:id, :name],
                    criterion: { id: "1" }
                  }
    expect(Select.parse(statement)).to eq(parsed_data)
  end
end
