defmodule CreatingABlogTest do
  use Blognix.ConnCase
  use Blognix.AuthenticationHelpers
  use Hound.Helpers

  alias Blognix.Blog
  alias Blognix.Repo

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
    current_user = Repo.get_by(Blognix.User, email: "test@test.com")
    new_blog = build(current_user, :blog)
    changeset = Blog.changeset(new_blog, %{title: "test", description: "blog"})
    blog = Repo.insert(changeset)
    split_url = Tuple.to_list(String.split_at(current_url(), 7))
    blog_url = blog.title <> "." <> List.last(split_url)
    navigate_to(blog_url)
    assert page_source =~ blog.title
    assert page_source =~ blog.description
  end
end
