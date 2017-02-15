require 'IMDB/queries/create_table'
require 'IMDB/queries/delete'
require 'IMDB/queries/insert'
require 'IMDB/queries/select'
require 'IMDB/queries/update'
require 'IMDB/queries/queries_manager'

module IMDB
  module Parser
    # Module which parses SQL statements
    module SQLParser
      # Partialy parses the SQL statement calling each statement`s corresponding class parser
      # and passing the parsed data for execution to QueriesManager.
      # @param statement [String] the SQL statement to be parsed
      # @raise [DataBase::InvalidQuery] when the SQL statement is not valid
      def parse(statement)
        case statement
        when /CREATE/
          data = Queries::CreateTable.parse(statement)
          Queries::QueriesManager.create_table(data)
        when /INSERT/
          data = Queries::Insert.parse(statement)
          Queries::QueriesManager.insert(data)
        when /UPDATE/
          data = Queries::Update.parse(statement)
          Queries::QueriesManager.update(data)
        when /SELECT/
          data = Queries::Select.parse(statement)
          Queries::QueriesManager.retrieve(data)
        when /DELETE/
          data = Queries::Delete.parse(statement)
          Queries::QueriesManager.delete(data)
        else
          raise IMDB::DatabaseExceptions::InvalidQuery.new(statement)
        end
      end
    end
  end
end
