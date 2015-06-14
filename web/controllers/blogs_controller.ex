defmodule Blognix.BlogsController do
  use Blognix.Web, :controller
  alias Blognix.Repo
  alias Blognix.Blog

  plug Blognix.Plug.Authenticate when not action in [:index, :show]
  plug :scrub_params, "blog" when action in [:create, :update]
  plug :action

  def new(conn, _) do
    changeset = Blog.changeset(%Blog{})
    render conn, changeset: changeset
  end

  def create(conn, %{"blog" => blog_params}) do
    new_blog = build(conn.assigns.current_user, :blog)
    changeset = Blog.changeset(new_blog, blog_params)
    if changeset.valid? do
      blog = Repo.insert(changeset)

      conn
        |> put_flash(:info, "Successfully created your blog!")
        |> redirect(to: blogs_path(conn, :show, blog.slug))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def index(conn, _) do
    render conn
  end

  def show(conn, %{"id" => slug}) do
    blog = Repo.get_by(Blog, slug: slug)
    render conn, blog: blog
  end
end
