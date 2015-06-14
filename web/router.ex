defmodule Blognix.Router do
  use Blognix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :subdomain do
    plug :is_blog_subdomain
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/b", Blognix do
    pipe_through :browser

    get "/", BlogsController, :show
  end

  scope "/", Blognix do
    pipe_through [:browser, :subdomain] # Use the default browser stack

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete

    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :create

    resources "/blogs", BlogsController

    get "/", BlogsController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Blognix do
  #   pipe_through :api
  # end

  defp is_blog_subdomain(conn, _) do
    if Regex.match?(~r/\w+\.\w+/, conn.host) do
      conn
        |> redirect(to: "/b")
        |> halt
    else
      conn
    end
  end
end
