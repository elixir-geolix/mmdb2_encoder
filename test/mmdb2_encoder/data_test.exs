defmodule MMDB2Encoder.DataTest do
  use ExUnit.Case, async: true

  @test_values [
    {"binary length 0", :binary, ""},
    {"binary length 16", :binary, String.duplicate("x", 16)},
    {"binary length 29", :binary, String.duplicate("x", 29)},
    {"binary length 285", :binary, String.duplicate("x", 285)},
    {"binary length 65_821", :binary, String.duplicate("x", 65_821)},
    {"boolean false", :boolean, false},
    {"boolean true", :boolean, true},
    {"cache container", :cache_container, :cache_container},
    {"end marker", :end_marker, :end_marker}
  ]

  for {name, type, value} <- @test_values do
    test "encode decode cycle: #{name}" do
      encoded_auto = MMDB2Encoder.Data.encode(unquote(value))
      encoded_fixed = MMDB2Encoder.Data.encode(unquote(type), unquote(value))

      assert encoded_auto == encoded_fixed
      assert unquote(value) == MMDB2Decoder.Data.value(encoded_auto, 0, [])
      assert unquote(value) == MMDB2Decoder.Data.value(encoded_fixed, 0, [])
    end
  end
end
