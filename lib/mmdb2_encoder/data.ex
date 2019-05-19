defmodule MMDB2Encoder.Data do
  @moduledoc false

  # standard data types
  @extended 0

  # extended data types
  @extended_bool 7
  @extended_cache 5
  @extended_end_marker 6

  @doc """
  Encodes a value to the appropriate MMDB2 representation.
  """
  @spec encode(term) :: binary
  def encode(true), do: <<@extended::size(3), 1::size(5), @extended_bool>>
  def encode(false), do: <<@extended::size(3), 0::size(5), @extended_bool>>
  def encode(:cache), do: <<@extended::size(3), 0::size(5), @extended_cache>>
  def encode(:end), do: <<@extended::size(3), 0::size(5), @extended_end_marker>>
end
