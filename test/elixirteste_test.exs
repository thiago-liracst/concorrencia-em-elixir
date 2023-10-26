defmodule ElixirtesteTest do
  use ExUnit.Case
  doctest Elixirteste

  test "greets the world" do
    assert Elixirteste.hello() == :world
  end
end
