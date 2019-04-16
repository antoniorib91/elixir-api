defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiWeb do
    pipe_through :api
    scope "/v1" do
      scope "/accounts" do
        get "/all", AccountController, :index
      end
      scope "/account" do
        put "/deposit", AccountController, :deposit
        put "/withdraw", AccountController, :withdraw
        post "/transfer", AccountController, :transfer
      end
    end
  end
end
