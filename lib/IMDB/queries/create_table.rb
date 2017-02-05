require 'IMDB/table/table'

# Class which parses SQL CREATE statements
class CreateTable
  # Parses the whole SQL statement
  # @param statement [String] the SQL statement
  # @return [Hash] hash with the data extracted from the SQL statement - table`s name and columns
  def self.parse(statement)
    table   = get_table(statement)
    columns = get_columns(statement)
    { table_name: table, columns: columns }
  end

  private
  
  # Gets the table name from the SQL statement
  # @param statement [String] the SQL statement
  # @return [String] the name of the table
  def self.get_table(statement)
    table = (/(?<=CREATE TABLE)\s(?'table'\w+)/.match statement)[:table]
    table
  end

  # Gets the columns of the table from the SQL statement
  # @param statement [String] the SQL statement
  # @return [Hash] the table`s columns
  # @example
  #        statement  = "CREATE TABLE students(id integer NOT NULL, name text NOT NULL);"
  #        => columns = { id: {type: Fixnum, null: false}, name: {type: String, null: false} }
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
        when 'text'    then columns[column][:type] = String
        end
        case null
        when 'NOT NULL' then columns[column][:null] = false
        when 'NULL'     then columns[column][:null] = true
        end
      end
    end
    columns
  end
end
