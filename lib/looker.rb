require "looker/version"
require "looker/table"

module Looker
  def self.add(data={})
    data.each do |name, rows|
      table = Looker::Table.new(name, rows)
      if Looker.const_defined?(table.const_name)
        message = "Looker::#{table.const_name} is already defined!"
        raise ArgumentError.new(message)
      end
      Looker.const_set table.const_name, table
    end
  end
end
