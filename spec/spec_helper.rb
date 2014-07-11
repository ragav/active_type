# encoding: utf-8

$: << File.join(File.dirname(__FILE__), "/../../lib" )

require 'active_record'
require 'active_type'
require 'rspec/collection_matchers'

ActiveRecord::Base.default_timezone = :local

Dir["#{File.dirname(__FILE__)}/support/*"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/shared_examples/*"].each {|f| require f}


RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do
      begin
        example.run
      ensure
        raise ActiveRecord::Rollback
      end
    end
  end
end
