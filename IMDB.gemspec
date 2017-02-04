# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'IMDB/version'

Gem::Specification.new do |spec|
  spec.name          = "IMDB"
  spec.version       = '0.0.0'
  spec.authors       = ["Tsvetan Hristov"]
  spec.email         = ["tsvetanhristov@yahoo.com"]

  spec.summary       = " In-Memory Database "
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  #spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         =  [
         "lib/IMDB.rb", "lib/IMDB/parser/sql_parser.rb", "lib/IMDB/queries/create_table.rb", "lib/IMDB/queries/delete.rb",
         "lib/IMDB/queries/insert.rb", "lib/IMDB/queries/select.rb", "lib/IMDB/queries/update.rb", "lib/IMDB/queries/queries_manager.rb",
         "lib/IMDB/table/data_record.rb", "lib/IMDB/table/table.rb"
  ]
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
