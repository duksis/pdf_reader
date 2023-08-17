defmodule PdfReader.Buffer do
  @moduledoc """
  A string tokeniser that recognises PDF grammar. When passed a
  string, tokens/1 will return a list of tokens from the source.

  This is very low level, and getting the raw tokens is not very useful in itself.

  This will usually be used in conjunction with PdfReader.Parser, which converts
  the raw tokens into objects we can work with (strings, ints, arrays, etc)
  """

  @doc """
  Extract list of tokes from raw PDF

  ## Examples

      iex> PdfReader.Buffer.tokens("<<")
      ["<<"]
      iex> PdfReader.Buffer.tokens("a")
      ["a"]
      iex> PdfReader.Buffer.tokens("<< /")
      ["<<", "/"]
  """
  def tokens(source) do
    case String.split(source, "", trim: true) |> Enum.reduce({[], []}, &build_token/2) do
      {[], res} -> Enum.reverse(res)
      {rem, res} -> [Enum.reverse(rem) |> Enum.join() | Enum.reverse(res)] |> Enum.reverse()
    end
  end

  defp state(last_token, _remaining_source) do
    case last_token do
      "(" -> :literal_string
      "<" -> :hex_string
      "stream" -> :stream
      "id" -> :inline
      _ -> :regular
    end
  end

  defp build_token(char, {prev, ready}) do
    case {char, List.first(prev)} do
      {"<", "<"} -> {[], ["<<" | ready]}
      _ -> {[char | prev], ready}
    end
  end
end
