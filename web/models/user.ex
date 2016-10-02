defmodule GenderService.User do
  use GenderService.Web, :model

  schema "users" do
    field :user_id, :integer
    belongs_to :gender, GenderService.Gender

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id])
    |> validate_required([:user_id])
  end
end
