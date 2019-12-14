defmodule MMDB2Encoder.Data do
  @moduledoc false

  # standard data types
  @binary 2
  @bytes 4
  @extended 0

  # extended data types
  @extended_boolean 7
  @extended_cache_container 5
  @extended_end_marker 6

  @type datatype :: :binary | :boolean | :bytes | :cache_container | :end_marker
  @type valuetype :: binary | boolean | :cache_container | :end_marker

  @doc """
  Encodes a value with automatic type selection.
  """
  @spec encode(value :: valuetype) :: <<_::8>>
  def encode(value) when is_binary(value), do: encode(:binary, value)
  def encode(value) when is_boolean(value), do: encode(:boolean, value)
  def encode(:cache_container), do: encode(:cache_container, :cache_container)
  def encode(:end_marker), do: encode(:end_marker, :end_marker)

  @doc """
  Encodes a value to the appropriate MMDB2 representation.
  """
  @spec encode(type :: datatype, value :: valuetype) :: <<_::8>>
  def encode(:binary, ""), do: <<@binary::size(3), 0::size(5)>>

  def encode(:binary, binary) when is_binary(binary) and byte_size(binary) >= 65_821,
    do: <<@binary::size(3), 31::size(5), byte_size(binary) - 65_821::size(24), binary::binary>>

  def encode(:binary, binary) when is_binary(binary) and byte_size(binary) >= 285,
    do: <<@binary::size(3), 30::size(5), byte_size(binary) - 285::size(16), binary::binary>>

  def encode(:binary, binary) when is_binary(binary) and byte_size(binary) >= 29,
    do: <<@binary::size(3), 29::size(5), byte_size(binary) - 29::size(8), binary::binary>>

  def encode(:binary, binary) when is_binary(binary),
    do: <<@binary::size(3), byte_size(binary)::size(5), binary::binary>>

  def encode(:boolean, true), do: <<@extended::size(3), 1::size(5), @extended_boolean>>
  def encode(:boolean, false), do: <<@extended::size(3), 0::size(5), @extended_boolean>>

  def encode(:bytes, ""), do: <<@bytes::size(3), 0::size(5)>>

  def encode(:bytes, bytes) when is_binary(bytes) and byte_size(bytes) >= 65_821,
    do: <<@bytes::size(3), 31::size(5), byte_size(bytes) - 65_821::size(24), bytes::binary>>

  def encode(:bytes, bytes) when is_binary(bytes) and byte_size(bytes) >= 285,
    do: <<@bytes::size(3), 30::size(5), byte_size(bytes) - 285::size(16), bytes::binary>>

  def encode(:bytes, bytes) when is_binary(bytes) and byte_size(bytes) >= 29,
    do: <<@bytes::size(3), 29::size(5), byte_size(bytes) - 29::size(8), bytes::binary>>

  def encode(:bytes, bytes) when is_binary(bytes),
    do: <<@bytes::size(3), byte_size(bytes)::size(5), bytes::binary>>

  def encode(:cache_container, :cache_container),
    do: <<@extended::size(3), 0::size(5), @extended_cache_container>>

  def encode(:end_marker, :end_marker),
    do: <<@extended::size(3), 0::size(5), @extended_end_marker>>
end
