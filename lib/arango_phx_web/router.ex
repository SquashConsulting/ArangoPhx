defmodule ArangoPhxWeb.Router do
  use ArangoPhxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ArangoPhxWeb do
    pipe_through :api

    get "/users/keys", UserController, :get_keys
    resources "/users", UserController, except: [:new, :edit]
  end
end
