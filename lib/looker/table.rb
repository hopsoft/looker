require "forwardable"

module Looker
  class Table
    extend Forwardable
    include Enumerable
    def_delegators :entries, :each
    attr_reader :name, :constant_name, :entries

    def self.constant_name(name)
      name.gsub(/\s/, "_").gsub(/\W/, "").upcase
    end

    def initialize(name, entries={})
      @name = name.to_s.strip.freeze
      @constant_name = self.class.constant_name(@name).freeze
      @entries = entries.dup.freeze
      @dict = entries.invert.merge(entries).freeze
      freeze
    end

    def [](key)
      dict[key] || dict[key.to_s] || dict[key.to_s.to_sym]
    end

    def to_h
      entries
    end

    private

    attr_reader :dict
  end
end
