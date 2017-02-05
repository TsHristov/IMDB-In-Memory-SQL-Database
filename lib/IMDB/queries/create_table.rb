require 'IMDB/table/table'

# Class which parses SQL CREATE statements
class CreateTable
  def self.parse(statement)
    table   = get_table(statement)
    columns = get_columns(statement)
    { table_name: table, columns: columns }
  end

  def self.get_table(statement)
    table = (/(?<=CREATE TABLE)\s(?'table'\w+)/.match statement)[:table]
    table
  end

  def self.get_columns(statement)
    match_columns = (/(?<=\()(?'columns'.+)(?=\);)/.match statement)[:columns]
    match_columns = match_columns.split(', ')
    columns = {}
    match_columns.each do |statement|
      /(?'column'\w+)\s(?'type'\w+)\s(?'null'\w+.+)/.match statement do |match|
        column = match[:column].to_sym
        type = match[:type]
        null = match[:null]
        columns[column] = {}
        case type
        when 'integer' then columns[column][:type] = Fixnum
        when 'text' then columns[column][:type] = String
        end
        case null
        when 'NOT NULL' then columns[column][:null] = false
        when 'NULL' then columns[column][:null] = true
        end
      end
    end
    columns
  end
end
