require 'spec_helper'

describe IMDB do
  it 'creates a DataBase object' do
    expect(DataBase.connect).to be_a DataBase
  end
end
