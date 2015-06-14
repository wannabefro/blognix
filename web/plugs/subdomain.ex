defmodule Blognix.Plug.Subdomain do
  import Plug.Conn
  import Blognix.Router.Helpers

  def init(default), do: default

  def call(conn, default) do
    slug = List.first(String.split(conn.host, "."))
    if slug && slug != conn.host do
      assign(conn, :subdomain, slug)
    else
      conn
    end
  end
end
