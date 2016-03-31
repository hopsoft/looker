require_relative "test_helper"

module Looker
  class TableTest < PryTest::Test

    before do
      @colors = {
        red: "#FF0000",
        blue: "#0000FF",
        yellow: "#FFFF00"
      }
      @table = Looker::Table.new(:colors, @colors)
    end

    test "name" do
      assert @table.name == "colors"
      assert Looker::Table.new("Foo Bar").name == "Foo Bar"
    end

    test "const_name" do
      assert @table.const_name == "COLORS"
      assert Looker::Table.new("Foo Bar").const_name == "FOO_BAR"
    end

    test "fozen?" do
      assert @table.frozen?
      assert @table.name.frozen?
      assert @table.rows.frozen?
      assert @table.send(:dict).frozen?
    end

    test "rows" do
      assert @table.rows == @colors
    end

    test "to_a" do
      assert @table.to_a == [[:red, "#FF0000"], [:blue, "#0000FF"], [:yellow, "#FFFF00"]]
    end

    test "[] find by key" do
      assert @table[:red] == "#FF0000"
      assert @table[:blue] == "#0000FF"
      assert @table[:yellow] == "#FFFF00"
    end

    test "[] find by value" do
      assert @table["#FF0000"] == :red
      assert @table["#0000FF"] == :blue
      assert @table["#FFFF00"] == :yellow
    end

  end
end

