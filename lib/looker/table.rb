require "forwardable"

module Looker
  class Table
    extend Forwardable
    include Enumerable
    def_delegators :rows, :each
    attr_reader :name, :constant_name, :rows

    def self.constant_name(name)
      name.gsub(/\s/, "_").gsub(/\W/, "").upcase
    end

    def initialize(name, rows={})
      @name = name.to_s.strip.freeze
      @constant_name = self.class.constant_name(@name).freeze
      @rows = rows.dup.freeze
      @dict = rows.invert.merge(rows).freeze
      freeze
    end

    def [](key)
      dict[key] || dict[key.to_s] || dict[key.to_s.to_sym]
    end

    def to_h
      rows
    end

    private

    attr_reader :dict
  end
end
