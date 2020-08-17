defmodule DeputyTest do
  use ExUnit.Case
  doctest Deputy

  test "greets the world" do
    assert Deputy.hello() == :world
  end
end
