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
      assert Looker::PRIMARY.rows == data["primary"]

      assert Looker.const_defined?(:REDS)
      assert Looker::REDS.is_a?(Looker::Table)
      assert Looker::REDS.rows == data["reds"]

      assert Looker.const_defined?(:PINKS)
      assert Looker::PINKS.is_a?(Looker::Table)
      assert Looker::PINKS.rows == data["pinks"]
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

    test "tables" do
      Looker.add table_a: {one: 1, two: 2}, table_b: { foo: true, bar: false }

      table_a = Looker.tables.find { |t| t.name == "table_a" }
      assert !table_a.nil?
      assert table_a.to_h == {one: 1, two: 2}

      table_b = Looker.tables.find { |t| t.name == "table_b" }
      assert !table_b.nil?
      assert table_b.to_h == { foo: true, bar: false }
    end

  end
end
