defmodule GameApi.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :data, :string

      timestamps()
    end

  end
end
