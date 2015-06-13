defmodule Blognix.Plug.CurrentUser do
  import Plug.Conn
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, default) do
    current_user = get_session(conn, :current_user)
    if current_user do
      assign(conn, :current_user, current_user)
    else
      conn
    end
  end
end
