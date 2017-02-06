DataRecord = IMDB::Table::DataRecord

describe DataRecord do
  before(:each) do
    columns = [:id, :name]
    values  = ["1", "'FirstName'"]
    @record = DataRecord.new columns, values
  end

  describe '#new' do

    it 'creates a data record' do
      data = { id: "1", name: "'FirstName'" }
      expect(@record.values).to eq(data)
    end

    it 'has getters and setters for the columns' do
      expect(DataRecord.instance_methods(false)).to include(*[:id, :id=, :name, :name=])
    end

    it 'can get a record value' do
      expect(@record.id).to eq("1")
      expect(@record.name).to eq("'FirstName'")
    end

    it 'can set a record`s value' do
      expect(@record.id).to eq("1")
      expect(@record.name).to eq("'FirstName'")
      @record.id   = "2"
      @record.name = "'LastName'"
      expect(@record.id).to eq("2")
      expect(@record.name).to eq("'LastName'")
    end
  end

  describe "#update" do
    it 'updates the record' do
      field = :id
      value = "5"
      @record.update(field, value)
      expect(@record.id).to eq("5")
    end
  end

  describe "#==" do
    it 'can compare records' do
      columns = [:id, :name]
      values  = ["1", "'FirstName'"]
      record = DataRecord.new columns, values
      expect(@record).to eq(record)
    end
  end

  describe "#match_query" do
    it 'checks whether the record has key, value pair matching query' do
      query = { id: "1" }
      expect(@record.match_query(query)).to be(true)
      query = {}
      expect(@record.match_query(query)).to be(true)
      query = { id: "1", name: "'FirstName'" }
      expect(@record.match_query(query)).to be(true)
      query = { id: "2", name: "'FirstName'" }
      expect(@record.match_query(query)).to be(false)
    end
  end
end
