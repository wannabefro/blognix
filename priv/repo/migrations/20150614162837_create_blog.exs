defmodule Blognix.Repo.Migrations.CreateBlog do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :slug, :string
      add :title, :string
      add :description, :text
      add :user_id, :integer

      timestamps
    end
    create index(:blogs, [:user_id], unique: true)
    create index(:blogs, [:slug], unqiue: true)
    create index(:blogs, [:title], unqiue: true)

  end
end
