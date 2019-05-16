defmodule MMDB2Encoder do
  @moduledoc """
  MMDB2 file format encoder.
  """

  # standard data types
  @extended 0

  # extended data types
  @extended_bool 7

  @doc """
  Encodes a value to the appropriate MMDB2 representation.
  """
  @spec encode(term) :: binary
  def encode(true), do: <<@extended::size(3), 1::size(5), @extended_bool>>
  def encode(false), do: <<@extended::size(3), 0::size(5), @extended_bool>>
end
