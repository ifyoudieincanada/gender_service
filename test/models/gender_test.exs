defmodule GenderService.GenderTest do
  use GenderService.ModelCase

  alias GenderService.Gender

  @valid_attrs %{accusative: "some content", name: "some content", nominative: "some content", predicative_possessive: "some content", pronomial_possessive: "some content", reflexive: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Gender.changeset(%Gender{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Gender.changeset(%Gender{}, @invalid_attrs)
    refute changeset.valid?
  end
end
