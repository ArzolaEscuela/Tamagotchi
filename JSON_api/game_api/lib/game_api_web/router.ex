defmodule GameApiWeb.Router do
  use GameApiWeb, :router
    pipeline :api do
      plug :accepts, ["json"]
    end

    scope "/api", GameApiWeb do
      pipe_through :api
      resources "/games", GameController, except: [:new, :edit]
    end
end
