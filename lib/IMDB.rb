require 'IMDB/parser/sql_parser'

module DatabaseExceptions
  class TableDoesNotExist < StandardError
    def initialize(table)
      super "No table named '#{table}' exists in the database"
    end
  end

  class InvalidQuery < StandardError
    def initialize(query)
      super "Invalid query: #{query}"
    end
  end
end

class Database
  include SQLParser
  include DatabaseExceptions

  class << self
    attr_accessor :tables
  end

  @tables = {}

  def self.create_table(table)
    Database.tables[table.name] = table
  end

  def self.connect
    return new
  end

  def self.find_table(table)
    raise DatabaseExceptions::TableDoesNotExist.new(table) unless @tables[table]
    @tables[table]
  end

  def execute(statement)
    parse(statement)
  end

  def commit
    # => TO-DO
  end
end

connection = Database.connect
connection.execute("CREATE TABLE students(id integer NOT NULL, name text NOT NULL);")
connection.execute("INSERT INTO students (id, name) VALUES (1, 'Tsvetan');")
connection.execute("INSERT INTO students (id, name) VALUES (2, 'Tsvetan');")
connection.execute("UPDATE students SET name = 'Tsvetan Hristov Hristov' WHERE id = 1;")
connection.execute("SELECT id, name FROM students;")
connection.execute("DELETE FROM students WHERE id = 1;")
