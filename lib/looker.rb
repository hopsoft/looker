require "forwardable"
require "looker/version"
require "looker/table"

module Looker
  class << self
    extend Forwardable
    include Enumerable
    def_delegators :@tables, :each

    def add(data={})
      data.each do |name, entries|
        table = Looker::Table.new(name, entries)
        if Looker.const_defined?(table.constant_name)
          message = "Looker::#{table.constant_name} is already defined!"
          raise ArgumentError.new(message)
        end
        Looker.const_set table.constant_name, table
        (@tables ||= []) << table
      end
    end

  end
end
