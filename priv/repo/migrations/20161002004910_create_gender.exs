defmodule GenderService.Repo.Migrations.CreateGender do
  use Ecto.Migration

  def change do
    create table(:genders) do
      add :name, :string
      add :nominative, :string
      add :accusative, :string
      add :pronomial_possessive, :string
      add :predicative_possessive, :string
      add :reflexive, :string

      timestamps()
    end

  end
end
