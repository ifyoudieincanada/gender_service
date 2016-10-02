defmodule GenderService.GenderControllerTest do
  use GenderService.ConnCase

  alias GenderService.Gender
  @valid_attrs %{accusative: "some content", name: "some content", nominative: "some content", predicative_possessive: "some content", pronomial_possessive: "some content", reflexive: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, gender_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    gender = Repo.insert! %Gender{}
    conn = get conn, gender_path(conn, :show, gender)
    assert json_response(conn, 200)["data"] == %{"id" => gender.id,
      "name" => gender.name,
      "nominative" => gender.nominative,
      "accusative" => gender.accusative,
      "pronomial_possessive" => gender.pronomial_possessive,
      "predicative_possessive" => gender.predicative_possessive,
      "reflexive" => gender.reflexive}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, gender_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, gender_path(conn, :create), gender: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Gender, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, gender_path(conn, :create), gender: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    gender = Repo.insert! %Gender{}
    conn = put conn, gender_path(conn, :update, gender), gender: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Gender, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    gender = Repo.insert! %Gender{}
    conn = put conn, gender_path(conn, :update, gender), gender: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    gender = Repo.insert! %Gender{}
    conn = delete conn, gender_path(conn, :delete, gender)
    assert response(conn, 204)
    refute Repo.get(Gender, gender.id)
  end
end
