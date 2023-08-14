defmodule PdfReader.PDF do
  @moduledoc """
  Representation of a PDF file
  """
  defstruct [:raw, :version, :page_count]
end
