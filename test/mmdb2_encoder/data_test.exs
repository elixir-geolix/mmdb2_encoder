defmodule MMDB2Encoder.DataTest do
  use ExUnit.Case, async: true

  @test_values [
    {"boolean false", false},
    {"boolean true", true},
    {"cache marker", :cache},
    {"end marker", :end}
  ]

  for {name, value} <- @test_values do
    test "encode decode cycle: #{name}" do
      assert unquote(value) ==
               unquote(value) |> MMDB2Encoder.Data.encode() |> MMDB2Decoder.Data.value(0)
    end
  end
end
