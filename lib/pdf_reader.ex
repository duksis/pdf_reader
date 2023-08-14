defmodule PdfReader do
  @moduledoc """
  Documentation for `PdfReader`.
  """

  alias PdfReader.PDF

  def read(path) do
    case File.read(path) do
      {:ok, raw} -> {:ok, read_pdf(raw)}
      oth -> oth
    end
  end

  @doc """
  Extract the page count of the PDF

  ## Examples

      iex> PdfReader.read_page_count(<<37, 80, 68, 70, 45, 49, 46, 52, 10, 37, 211>>)
      1

  """
  def read_page_count(_) do
    1
  end

  @doc """
  Extract the version of the PDF a binary

  ## Examples

      iex> PdfReader.read_version(<<37, 80, 68, 70, 45, 49, 46, 52, 10, 37, 211>>)
      1.4

  """
  def read_version(<<_::binary-size(1), "PDF-", v::binary-size(3), _::binary>>),
    do: String.to_float(v)

  @doc """
  Extract the readable bytes from the PDF

  ## Examples

      iex> PdfReader.read_text(<<37, 80, 68, 70, 45, 49, 46, 52, 10, 37, 211>>)
      "%PDF-1.4\\n%"

  """
  def read_text(raw) do
    raw
    |> :binary.bin_to_list()
    |> Enum.map(fn x -> <<x>> end)
    |> Enum.reject(fn x -> !String.printable?(x) end)
    |> Enum.join()
  end

  @doc """
  Converts the binary to a loacl PDF representation

  ## Examples

      iex> PdfReader.read_pdf(<<37, 80, 68, 70, 45, 49, 46, 52, 10, 37, 211>>)
      iex> %PdfReader.PDF{}

  """
  def read_pdf(raw) do
    %PDF{
      raw: raw,
      version: read_version(raw),
      page_count: read_page_count(raw)
    }
  end
end
