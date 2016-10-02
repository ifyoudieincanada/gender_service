defmodule GenderService.Gender do
  use GenderService.Web, :model

  schema "genders" do
    field :name, :string
    field :nominative, :string # He/She
    field :accusative, :string # Him/Her
    field :pronomial_possessive, :string # His/Her
    field :predicative_possessive, :string # His/Hers
    field :reflexive, :string # Himself/Herself
    field :user_id, :integer, virtual: true
    has_many :users, GenderService.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :name, :nominative, :accusative, :pronomial_possessive, :predicative_possessive, :reflexive])
    |> validate_required([:user_id, :nominative, :accusative, :pronomial_possessive, :predicative_possessive, :reflexive])
    |> set_user_id
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :name, :nominative, :accusative, :pronomial_possessive, :predicative_possessive, :reflexive])
    |> validate_required([:user_id, :nominative, :accusative, :pronomial_possessive, :predicative_possessive, :reflexive])
    |> add_user_id
  end

  defp set_user_id(%{valid?: false} = changeset), do: changeset
  defp set_user_id(changeset) do
    user_id = Ecto.Changeset.get_field(changeset, :user_id)

    user =
      case GenderService.Repo.one(from u in GenderService.User, where: u.user_id == ^user_id) do
        nil -> %GenderService.User{user_id: user_id}
        user -> user
      end

    Ecto.Changeset.put_assoc(changeset, :users, [user])
  end

  defp add_user_id(%{valid?: false} = changeset), do: changeset
  defp add_user_id(changeset) do
    name = Ecto.Changeset.get_field(changeset, :name)
    nominative = Ecto.Changeset.get_field(changeset, :nominative)
    accusative = Ecto.Changeset.get_field(changeset, :accusative)
    pro_pos = Ecto.Changeset.get_field(changeset, :pronomial_possessive)
    pre_pos = Ecto.Changeset.get_field(changeset, :predicative_possessive)
    reflexive = Ecto.Changeset.get_field(changeset, :reflexive)

    gender = Gender
             |> by_name(name)
             |> by_nominative(nominative)
             |> by_accusative(accusative)
             |> by_pronomial_possessive(pro_pos)
             |> by_predicative_possessive(pre_pos)
             |> by_reflexive(reflexive)
             |> preload_users
             |> GenderService.Repo.one

    user_id = Ecto.Changeset.get_field(changeset, :user_id)

    user =
      case GenderService.Repo.one(from u in GenderService.User, where: u.user_id == ^user_id) do
        nil -> %GenderService.User{user_id: user_id}
        user -> user
      end

    Ecto.Changeset.put_assoc(changeset, :users, [user | gender.users])
  end

  def preload_users(query) do
    from q in query,
      preload: [:users]
  end

  def by_name(query, name) do
    from q in query,
      where: q.name == ^name
  end
  def by_nominative(query, nominative) do
    from q in query,
      where: q.nominative == ^nominative
  end
  def by_accusative(query, accusative) do
    from q in query,
      where: q.accusative == ^accusative
  end
  def by_predicative_possessive(query, predicative_possessive) do
    from q in query,
      where: q.predicative_possessive == ^predicative_possessive
  end
  def by_pronomial_possessive(query, pronomial_possessive) do
    from q in query,
      where: q.pronomial_possessive == ^pronomial_possessive
  end
  def by_reflexive(query, reflexive) do
    from q in query,
      where: q.reflexive == ^reflexive
  end
end
