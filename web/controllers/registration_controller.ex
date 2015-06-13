defmodule Blognix.RegistrationController do
  use Blognix.Web, :controller
  alias Blognix.Repo

  plug :action

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    if changeset.valid? do
      new_user = Repo.insert(changeset)

      conn
        |> put_flash(:info, "Successfully registered and logged in")
        |> put_session(:current_user, new_user)
        |> redirect(to: page_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end
end
