defmodule Blognix.User do
  use Blognix.Web, :model
  alias Blognix.Repo

  schema "users" do
    field :username, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    has_one :blog, Blognix.Blog

    timestamps
  end

  @required_fields ~w(username email password password_confirmation)
  @optional_fields ~w()
  @email_regex ~r/^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  before_insert Blognix.Password, :generate_password

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """


  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_unique(:username, on: Repo, downcase: true)
    |> validate_unique(:email, on: Repo, downcase: true)
    |> validate_format(:email, @email_regex)
    |> validate_length(:password, min: 8)
    |> validate_length(:password_confirmation, min: 8)
    |> validate_confirmation(:password)
  end

end
