defmodule Pento.Repo.Migrations.AddUsernameField do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, null: false, default: ""
    end

    create unique_index(:users, [:username])
  end
end
