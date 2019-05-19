defmodule MMDB2Encoder.DataTest do
  use ExUnit.Case, async: true

  @test_values [
    false,
    true,
    :cache,
    :end
  ]

  test "encode decode cycle" do
    for value <- @test_values do
      assert value == value |> MMDB2Encoder.Data.encode() |> MMDB2Decoder.Data.value(0)
    end
  end
end
