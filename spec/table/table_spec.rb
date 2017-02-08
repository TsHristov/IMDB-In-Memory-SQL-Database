Table = IMDB::Table::Table

describe Table do
  before(:each) do
    table_name = 'studens'
    columns = {
                id:   {type: Fixnum, null: false},
                name: {type: String, null: false},
              }
    @table = Table.new table_name, columns
  end

  before(:each) do
    columns =  ["id", "name"]
    values  =  ["1", "'Student'"]
    @first_record   =  DataRecord.new columns, values
    columns =  ["id", "name"]
    values  =  ["2", "'Another Student'"]
    @second_record  =  DataRecord.new columns, values
  end

  describe '#create' do
    it 'creates a table in the database' do
      table_name = 'studens'
      columns = {
                  id:   {type: Fixnum, null: false},
                  name: {type: String, null: false},
                }
      table = Table.new table_name, columns
      Table.create(table_name, columns)
      expect(IMDB::DB.tables[table_name]).to eq(table)
    end
  end

  describe '#insert' do
    it 'inserts a data record in the table' do
      @table.insert(@first_record)
      expect(@table.data).to include(@first_record)
    end
  end

  describe '#retrieve' do
    it 'select data from the table' do
      @table.insert(@first_record)
      expect(@table.retrieve([:id], {id: "1"})).to eq([{id: "1"}])
      expect(@table.retrieve([:id, :name], {id: "1"})).to eq([{id: "1", name: "'Student'"}])
      expect(@table.retrieve([:name], {id: "1"})).to eq([{name: "'Student'"}])
      @table.insert(@second_record)
      expect(@table.retrieve([:name], {})).to eq([{name: "'Student'"}, {name: "'Another Student'"}])
    end
  end

  describe '#update' do
    it 'updates record`s field with value based on a condition' do
      columns =  ["id", "name"]
      values  =  ["1", "'Student'"]
      record  =  DataRecord.new columns, values
      @table.insert(record)
      field     =  :name
      value     = "'STUDENT NAME'"
      criterion =  { id: "1" }
      @table.update(field, value, criterion)
      expect(record.values[field]).to eq("'STUDENT NAME'")
    end

    it 'does not update record if it doesnt match query' do
      columns =  ["id", "name"]
      values  =  ["1", "'Student'"]
      record  =  DataRecord.new columns, values
      @table.insert(record)
      field     =  :name
      value     = "'STUDENT NAME'"
      criterion =  { id: "invalid value" }
      @table.update(field, value, criterion)
      expect(record.values[field]).to eq("'Student'")
    end
  end

  describe '#delete' do
    it 'deletes single record from the table' do
      @table.insert(@first_record)
      @table.delete(@first_record)
      expect(@table.data).not_to include(@first_record)
    end

    it 'deletes multiple records from the table' do
      @table.insert(@first_record)
      @table.insert(@second_record)
      @table.delete([@first_record, @second_record])
      expect(@table.data).not_to include(@first_record)
      expect(@table.data).not_to include(@second_record)
    end
  end
end
