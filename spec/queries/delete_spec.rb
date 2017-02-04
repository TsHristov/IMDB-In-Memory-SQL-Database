describe Delete do
  it 'gets the name of the table' do
    statement = "DELETE FROM students WHERE id = 1;"
    expect(Delete.get_table(statement)).to eq('students')
  end

  it 'gets the query criterion' do
    statement = "DELETE FROM students WHERE id = 1;"
    criterion = { id: "1" }
    expect(Delete.get_criterion(statement)).to eq(criterion)
  end

  it 'successfully parses the SQL query' do
    statement = "DELETE FROM students WHERE id = 1;"
    parsed_data = {
            table_name: 'students',
            criterion: { id: "1" },
           }
    expect(Delete.parse(statement)).to eq(parsed_data)
  end
end
