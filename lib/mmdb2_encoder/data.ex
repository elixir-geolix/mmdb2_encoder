defmodule MMDB2Encoder.Data do
  @moduledoc false

  # standard data types
  @binary 2
  @extended 0

  # extended data types
  @extended_bool 7
  @extended_cache 5
  @extended_end_marker 6

  @doc """
  Encodes a value to the appropriate MMDB2 representation.
  """
  @spec encode(term) :: binary
  def encode(""), do: <<@binary::size(3), 0::size(5)>>

  def encode(binary) when is_binary(binary) and byte_size(binary) >= 65_821,
    do: <<@binary::size(3), 31::size(5), byte_size(binary) - 65_821::size(24), binary::binary>>

  def encode(binary) when is_binary(binary) and byte_size(binary) >= 285,
    do: <<@binary::size(3), 30::size(5), byte_size(binary) - 285::size(16), binary::binary>>

  def encode(binary) when is_binary(binary) and byte_size(binary) >= 29,
    do: <<@binary::size(3), 29::size(5), byte_size(binary) - 29::size(8), binary::binary>>

  def encode(binary) when is_binary(binary),
    do: <<@binary::size(3), byte_size(binary)::size(5), binary::binary>>

  def encode(true), do: <<@extended::size(3), 1::size(5), @extended_bool>>
  def encode(false), do: <<@extended::size(3), 0::size(5), @extended_bool>>
  def encode(:cache), do: <<@extended::size(3), 0::size(5), @extended_cache>>
  def encode(:end), do: <<@extended::size(3), 0::size(5), @extended_end_marker>>
end