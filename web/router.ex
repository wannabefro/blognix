defmodule Blognix.Router do
  use Blognix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope alias: Blognix do
    pipe_through :browser # Use the default browser stack

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
end
