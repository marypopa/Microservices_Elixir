defmodule ConferenceTest do
  use ExUnit.Case
  doctest Conference

  test "greets the world" do
    assert Conference.hello() == :world
  end
end
