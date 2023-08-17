defmodule PdfReader.BufferTest do
  use ExUnit.Case
  alias PdfReader.Buffer

  doctest Buffer

  test "#tokens/1 - extracts a list of tokens from raw PDF" do
    assert ["<<", "/", "X", {10, 0}, "/", "Y", {11, 0}] == Buffer.tokens("<< /X 10 0 R /Y 11 0 R >>")
  end
end
