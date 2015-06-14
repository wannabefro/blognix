defmodule Blognix.BlogTest do
  use Blognix.ModelCase

  alias Blognix.Blog

  @valid_attrs %{description: "some content", slug: "some content", title: "some content", user: nil}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Blog.changeset(%Blog{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Blog.changeset(%Blog{}, @invalid_attrs)
    refute changeset.valid?
  end
end
