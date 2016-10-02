defmodule GenderService.GenderView do
  use GenderService.Web, :view

  def render("index.json", %{genders: genders}) do
    %{data: render_many(genders, GenderService.GenderView, "gender.json")}
  end

  def render("show.json", %{gender: gender}) do
    %{data: render_one(gender, GenderService.GenderView, "gender.json")}
  end

  def render("gender.json", %{gender: gender}) do
    %{id: gender.id,
      name: gender.name,
      nominative: gender.nominative,
      accusative: gender.accusative,
      pronomial_possessive: gender.pronomial_possessive,
      predicative_possessive: gender.predicative_possessive,
      reflexive: gender.reflexive}
  end
end
