defmodule SigningInTest do
  use Blognix.ConnCase
  use Hound.Helpers

  alias Blognix.User
  alias Blognix.Repo

  hound_session

  @valid_user_attrs %{email: "test@test.com", password: "password",
    password_confirmation: "password", username: "test"}

  setup do
    changeset = User.changeset(%User{}, @valid_user_attrs)
    Repo.insert(changeset)
    :ok
  end

  test "signing in" do
    navigate_to("/login")
    fill_field({:id, "user_email"}, @valid_user_attrs.email)
    fill_field({:id, "user_password"}, @valid_user_attrs.password)
    click({:css, "input[value='Login']"})

    assert page_source =~ "You are now signed in"
  end
end
