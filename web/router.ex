defmodule GenderService.Router do
  use GenderService.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GenderService do
    pipe_through :api

    resources "/genders", GenderController, except: [:new, :edit]
  end
end
