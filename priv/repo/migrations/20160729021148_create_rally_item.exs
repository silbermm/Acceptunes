defmodule Acceptunes.Repo.Migrations.CreateRallyItem do
  use Ecto.Migration

  def change do
    create table(:rally_items) do
      add :itemId, :integer

      timestamps
    end

    create unique_index(:rally_items, [:itemId])

  end
end
