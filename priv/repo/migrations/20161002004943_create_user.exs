defmodule GenderService.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_id, :integer
      add :gender_id, references(:genders, on_delete: :nothing)

      timestamps()
    end
    create index(:users, [:gender_id])

  end
end
