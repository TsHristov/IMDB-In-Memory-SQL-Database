describe Update do
  it 'gets the name of the table' do
    statement = "UPDATE students SET name = 'STUDENT NAME' WHERE id = 1;"
    expect(Update.get_table(statement)).to eq('students')
  end

  it 'gets the table`s field to be updated' do
    statement = "UPDATE students SET name = 'STUDENT NAME' WHERE id = 1;"
    field = "name"
    expect(Update.get_field(statement)).to eq(field)
  end

  it 'gets the field`s value to be updated' do
    statement = "UPDATE students SET name = 'STUDENT NAME' WHERE id = 1;"
    value = "'STUDENT NAME'"
    expect(Update.get_value(statement)).to eq(value)
  end

  it 'gets the criterion for the update' do
    statement = "UPDATE students SET name = 'STUDENT NAME' WHERE id = 1;"
    criterion = { id: "1" }
    expect(Update.get_criterion(statement)).to eq(criterion)
  end

  it 'successfully parses the SQL query' do
    statement = "UPDATE students SET name = 'STUDENT NAME' WHERE id = 1;"
    parsed_data = {
                    table_name: 'students',
                    field: "name",
                    value: "'STUDENT NAME'",
                    criterion: { id: "1" }
                  }
    expect(Update.parse(statement)).to eq(parsed_data)
  end
end
