defmodule MMDB2EncoderTest do
  use ExUnit.Case, async: true

  @test_values [
    false,
    true
  ]

  test "encode decode cycle" do
    for value <- @test_values do
      assert value == value |> MMDB2Encoder.encode() |> MMDB2Decoder.Data.value(0)
    end
  end
end
