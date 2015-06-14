defmodule Blognix.Blog do
  use Blognix.Web, :model
  alias Blognix.Repo

  schema "blogs" do
    field :slug, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Blognix.User

    timestamps
  end

  @required_fields ~w(title description user_id)
  @optional_fields ~w()

  before_insert Blognix.Slugify, :generate_slug

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_unique(:title, on: Repo, downcase: true)
  end
end
