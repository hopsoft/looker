require "yaml"
require_relative "test_helper"

module Looker
  class LookerTest < PryTest::Test

    test "add" do
      Looker.add(
        groups: {
          admin: 1,
          reader: 2,
          writer: 3
        },

        roman_numerals: {
          one: "I",
          two: "II",
          three: "III",
          four: "IV",
          five: "V"
        }
      )

      assert Looker.const_defined?(:GROUPS)
      assert Looker::GROUPS.is_a?(Looker::Table)
      assert Looker::GROUPS[:reader] == 2
      assert Looker::GROUPS[2] == :reader

      assert Looker.const_defined?(:ROMAN_NUMERALS)
      assert Looker::ROMAN_NUMERALS.is_a?(Looker::Table)
      assert Looker::ROMAN_NUMERALS[:four] == "IV"
      assert Looker::ROMAN_NUMERALS["IV"] == :four
    end

    test "add from yaml file" do
      data = YAML.load(File.read(File.expand_path("../colors.yml", __FILE__)))
      Looker.add(data)

      assert Looker.const_defined?(:PRIMARY)
      assert Looker::PRIMARY.is_a?(Looker::Table)
      assert Looker::PRIMARY.entries == data["primary"]

      assert Looker.const_defined?(:REDS)
      assert Looker::REDS.is_a?(Looker::Table)
      assert Looker::REDS.entries == data["reds"]

      assert Looker.const_defined?(:PINKS)
      assert Looker::PINKS.is_a?(Looker::Table)
      assert Looker::PINKS.entries == data["pinks"]
    end

    test "can't re-define constant" do
      Looker.add(foo: { bar: true, baz: false })
      begin
        Looker.add(foo: { bar: true, baz: false })
      rescue ArgumentError => e
      end
      assert e
      assert e.message == "Looker::FOO is already defined!"
    end

    test "enumerable" do
      assert Looker.is_a?(Enumerable)
      assert Looker.respond_to?(:each)
    end

    test "to_a" do
      Looker.add(to_a: {array: true})
      a = Looker.to_a
      assert a.size > 0
    end

    test "each" do
      Looker.add(each: {enumerable: true})
      table = nil
      Looker.each { |t| table = t if t.name == "each" }
      assert table
    end

    test "find" do
      Looker.add(find: {enumerable: true})
      assert Looker.find { |t| t.constant_name == "FIND" }
    end
  end
end
