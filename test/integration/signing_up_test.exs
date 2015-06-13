defmodule SigningUpTest do
  use Blognix.ConnCase
  use Hound.Helpers

  hound_session

  test "signing up" do
    navigate_to("/registration")
    fill_field({:id, "user_username"}, "test")
    fill_field({:id, "user_email"}, "test@test.com")
    fill_field({:id, "user_password"}, "password")
    fill_field({:id, "user_password_confirmation"}, "password")
    click({:css, "input[value='Register']"})

    assert page_source =~ "Successfully registered and logged in"
  end
end
