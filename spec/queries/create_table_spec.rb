describe CreateTable do

  it 'gets the name of the table' do
    statement = "CREATE TABLE students(id integer NOT NULL, name text NOT NULL);"
    expect(CreateTable.get_table(statement)).to eq('students')
  end

  it 'gets the columns of the table' do
    statement = "CREATE TABLE students(id integer NOT NULL, name text NOT NULL);"
    columns = {
                id:   {type: Fixnum, null: false},
                name: {type: String, null: false},
              }
    expect(CreateTable.get_columns(statement)).to eq(columns)
  end

  it 'successfully parses the SQL query' do
    statement = "CREATE TABLE students(id integer NOT NULL, name text NOT NULL);"
    parsed_data = {
             table_name: 'students',
             columns: {
                         id:   {type: Fixnum, null: false},
                         name: {type: String, null: false},
                      }
           }
    expect(CreateTable.parse(statement)).to eq(parsed_data)
  end
end
