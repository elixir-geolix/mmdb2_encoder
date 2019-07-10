defmodule MMDB2Encoder.DataTest do
  use ExUnit.Case, async: true

  @autodetectables [
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

  @undetectables [
    {"bytes length 0", :bytes, ""},
    {"bytes length 16", :bytes, String.duplicate("x", 16)},
    {"bytes length 29", :bytes, String.duplicate("x", 29)},
    {"bytes length 285", :bytes, String.duplicate("x", 285)},
    {"bytes length 65_821", :bytes, String.duplicate("x", 65_821)}
  ]

  for {name, type, value} <- @autodetectables do
    test "encode decode (auto) cycle: #{name}" do
      encoded_auto = MMDB2Encoder.Data.encode(unquote(value))
      encoded_fixed = MMDB2Encoder.Data.encode(unquote(type), unquote(value))

      assert unquote(value) == MMDB2Decoder.Data.value(encoded_auto, 0, [])
      assert unquote(value) == MMDB2Decoder.Data.value(encoded_fixed, 0, [])
    end
  end

  for {name, type, value} <- @undetectables do
    test "encode decode (auto) cycle: #{name}" do
      encoded_fixed = MMDB2Encoder.Data.encode(unquote(type), unquote(value))

      assert unquote(value) == MMDB2Decoder.Data.value(encoded_fixed, 0, [])
    end
  end
end
