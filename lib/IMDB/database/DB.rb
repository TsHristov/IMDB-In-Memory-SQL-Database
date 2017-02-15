require 'IMDB/parser/sql_parser'

module IMDB

  module DatabaseExceptions
    class TableDoesNotExist < StandardError
      def initialize(table)
        super "No table named '#{table}' exists in the DB"
      end
    end

    class TableExists < StandardError
      def initialize(table)
        super "Table named '#{table}' already exists in the DB"
      end
    end

    class InvalidQuery < StandardError
      def initialize(query)
        super "Invalid query: #{query}"
      end
    end
  end

  # Class which represents the DB.
  class DB
    include IMDB::Parser::SQLParser
    include DatabaseExceptions

    @tables = {}

    class << self
      attr_reader :tables

      # Creates a table in the DB
      # @param table [Table] the table to be created
      def create_table(table)
        raise IMDB::DatabaseExceptions::TableExists.new(table.name) if @tables.has_key? table.name
        @tables[table.name] = table
      end

      def connect
        return new
      end

      # Finds a table in the DB.
      # @param table [String] the name of the table to be found
      # @return [Table]
      def find_table(table)
        raise IMDB::DatabaseExceptions::TableDoesNotExist.new(table) unless @tables[table]
        @tables[table]
      end
    end

    # Executes a SQL statement agains the DB.
    # @param statement [String]
    def execute(sql_statement)
      parse(sql_statement)
    end
  end
end
