defmodule MMDB2Encoder.DataTest do
  use ExUnit.Case, async: true

  @test_values [
    {"binary length 0", ""},
    {"binary length 16", String.duplicate("x", 16)},
    {"binary length 29", String.duplicate("x", 29)},
    {"binary length 285", String.duplicate("x", 285)},
    {"binary length 65_821", String.duplicate("x", 65_821)},
    {"boolean false", false},
    {"boolean true", true},
    {"cache container", :cache_container},
    {"end marker", :end_marker}
  ]

  for {name, value} <- @test_values do
    test "encode decode cycle: #{name}" do
      assert unquote(value) ==
               unquote(value) |> MMDB2Encoder.Data.encode() |> MMDB2Decoder.Data.value(0, [])
    end
  end
end
