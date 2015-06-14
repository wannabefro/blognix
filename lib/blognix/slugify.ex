defmodule Blognix.Slugify do
  import Inflex
  alias Phitter.Repo
  import Ecto.Changeset, only: [put_change: 3]

  def generate_slug(changeset) do
    put_change(changeset, :slug, parameterize(changeset.params["title"]))
  end
end
