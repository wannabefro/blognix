defmodule CreatingABlogTest do
  use Blognix.ConnCase
  use Blognix.AuthenticationHelpers
  use Hound.Helpers

  @user_attrs %{email: "test@test.com", password: "password",
    password_confirmation: "password", username: "test"}

  hound_session

  setup do
    sign_in_as(@user_attrs)
    :ok
  end

  test "creating a blog" do
    navigate_to("/blogs/new")
    fill_field({:id, "blog_title"}, "test")
    fill_field({:id, "blog_description"}, "best blog ever")
    click({:css, "input[value='Create Blog']"})
    assert page_source =~ "Successfully created your blog!"
  end

  test "visiting a blog" do
  end
end
