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
    end
  end
end
