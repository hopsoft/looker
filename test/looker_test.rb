require "yaml"
require_relative "test_helper"

module Looker
  class LookerTest < PryTest::Test

    test "create_constants" do
      Looker.create_constants(
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

    test "create_constants from yaml file" do
      data = YAML.load(File.read(File.expand_path("../colors.yml", __FILE__)))
      Looker.create_constants(data)

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

  end
end
