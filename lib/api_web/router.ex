defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiWeb do
    pipe_through :api
    scope "/v1" do
      scope "/account" do
        get "/all", AccountController, :index
        get "/:id/summary", AccountController, :summary
        put "/deposit", AccountController, :deposit
        put "/withdraw", AccountController, :withdraw
        post "/transfer", AccountController, :transfer
      end
    end
  end
end
