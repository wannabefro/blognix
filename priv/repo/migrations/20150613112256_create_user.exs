defmodule Blognix.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :encrypted_password, :string, null: false

      timestamps
    end

    create index(:users, [:username], unique: true)
    create index(:users, [:email], unique: true)

  end
end
