defmodule PeriwinkleWeb.Router do
  use PeriwinkleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
  end

  scope "/api", PeriwinkleWeb do
    pipe_through :api

    get "/cases", CaseController, :index
    get "/case/:id", CaseController, :show
  end

  scope "/graphql" do
    pipe_through :graphql
    
    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: PeriwinkleWeb.Schema)
    forward("/", Absinthe.Plug, schema: PeriwinkleWeb.Schema)
  end

  scope "/", PeriwinkleWeb do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PeriwinkleWeb do
  #   pipe_through :api
  # end
end
