defmodule PdfReaderTest do
  use ExUnit.Case
  doctest PdfReader

  test "get pdf version of file" do
    {:ok, pdf} = PdfReader.read("test/support/hello-there.pdf")
    assert pdf.version == 1.4
  end

  test "#page_count" do
    {:ok, pdf} = PdfReader.read("test/support/cairo-basic.pdf")
    assert pdf.page_count == 2
  end
end
