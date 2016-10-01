defmodule GenderService.Router do
  use GenderService.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GenderService do
    pipe_through :api
  end
end
