defmodule Blognix.Plug.Authenticate do
  import Plug.Conn
  import Blognix.Router.Helpers
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, default) do
    current_user = conn.assigns.current_user
    if !current_user do
      conn
        |> put_flash(:error, "You need to be signed in to view this page")
        |> redirect(to: session_path(conn, :new))
    end
  end
end
