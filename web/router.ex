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

  scope "/", Blognix do
    pipe_through :browser # Use the default browser stack
    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :create

    get "/", PageController, :index
  end

  # Will be used for subdomained blog urls
  scope "/", host: "*." do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Blognix do
  #   pipe_through :api
  # end
end
