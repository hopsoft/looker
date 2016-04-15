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

    test "constant_name" do
      assert @table.constant_name == "COLORS"
      assert Looker::Table.new("Foo Bar").constant_name == "FOO_BAR"
    end

    test "fozen?" do
      assert @table.frozen?
      assert @table.name.frozen?
      assert @table.entries.frozen?
      assert @table.send(:dict).frozen?
    end

    test "entries" do
      assert @table.entries == @colors
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

    test "to_h" do
      assert @table.to_h == {
        :red    => "#FF0000",
        :blue   => "#0000FF",
        :yellow => "#FFFF00"
      }
    end

    test "indifferent access symbol keys accessed by string" do
      table = Looker::Table.new(:foo, a: true)
      assert table[:a]
      assert table["a"]
    end

    test "indifferent access string keys accessed by symbol" do
      table = Looker::Table.new(:foo, "a" => true)
      assert table[:a]
      assert table["a"]
    end

    test "enumerable" do
      assert @table.is_a?(Enumerable)
      assert @table.respond_to?(:each)
    end

    test "each" do
      colors = {}
      @table.each do |key, value|
        colors[key] = value
      end
      assert @table.to_h == colors
    end

    test "find" do
      red = @table.find { |key, _| key == :red }
      assert red == [:red, "#FF0000"]
    end
  end
end

