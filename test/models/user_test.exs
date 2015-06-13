defmodule Blognix.UserTest do
  use Blognix.ModelCase

  alias Blognix.User
  alias Blognix.Repo

  @valid_attrs %{email: "test@test.com", password: "password",
    password_confirmation: "password", username: "test"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "valid email" do
    invalid_email_attrs = %{@valid_attrs | email: "test.com"}
    changeset = User.changeset(%User{}, invalid_email_attrs)
    refute changeset.valid?
    assert changeset.errors[:email], "has invalid format"
  end

  test "valid password_confirmation" do
    invalid_password_confirmation_attrs = %{@valid_attrs |
      password_confirmation: "notsamepassword"}
    changeset = User.changeset(%User{}, invalid_password_confirmation_attrs)
    refute changeset.valid?
    assert changeset.errors[:password], "does not match confirmation"
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "it generates an encrypted password" do
    changeset = User.changeset(%User{}, @valid_attrs)
    user = Repo.insert(changeset)
    assert user.encrypted_password != nil
  end
end
