defmodule GenderService.UserView do
  use GenderService.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, GenderService.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, GenderService.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      user_id: user.user_id,
      gender_id: user.gender_id}
  end
end
