defmodule GenderService.GenderController do
  use GenderService.Web, :controller

  alias GenderService.Gender

  def index(conn, _params) do
    genders = Repo.all(Gender)
    render(conn, "index.json", genders: genders)
  end

  def create(conn, %{"gender" => gender_params, "token" => token}) do
    {:ok, user} = UserClient.User.verify(%UserClient.User{token: token})

    gender_params = Map.put(gender_params, :user_id, user.id)
    changeset = Gender.changeset(%Gender{}, gender_params)

    case Repo.insert(changeset) do
      {:ok, gender} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", gender_path(conn, :show, gender))
        |> render("show.json", gender: gender)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GenderService.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    gender = Repo.get!(Gender, id)
    render(conn, "show.json", gender: gender)
  end

  def update(conn, %{"id" => id, "gender" => gender_params, "token" => token}) do
    {:ok, user} = UserClient.User.verify(%UserClient.User{token: token})

    gender = Repo.get!(Gender, id)
    gender_params = Map.put(gender_params, :user_id, user.id)
    changeset = Gender.update_changeset(gender, gender_params)

    case Repo.update(changeset) do
      {:ok, gender} ->
        render(conn, "show.json", gender: gender)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GenderService.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gender = Repo.get!(Gender, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(gender)

    send_resp(conn, :no_content, "")
  end
end
