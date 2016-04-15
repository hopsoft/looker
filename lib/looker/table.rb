require "forwardable"

module Looker
  class Table
    extend Forwardable
    include Enumerable
    def_delegators :rows, :each
    def_delegator :dict, :[]
    attr_reader :name, :const_name, :rows

    def self.constant_name(name)
      name.to_s.dup.strip.gsub(/\s/, "_").gsub(/\W/, "").upcase
    end

    def initialize(name, rows={})
      @name = name.to_s.dup.freeze
      @const_name = self.class.constant_name(name).freeze
      @rows = rows.dup.freeze
      @dict = rows.invert.merge(rows).freeze
      freeze
    end

    def to_h
      rows
    end

    private

    attr_reader :dict
  end
end
