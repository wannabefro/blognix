defmodule Blognix.AuthenticationHelpers do

  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers
      alias Blognix.User
      alias Blognix.Repo

      def sign_in_as(user_attrs) do
        changeset = User.changeset(%User{}, user_attrs)
        user = Repo.insert(changeset)
        navigate_to("/login")
        fill_field({:id, "user_email"}, user_attrs.email)
        fill_field({:id, "user_password"}, user_attrs.password)
        click({:css, "input[value='Login']"})
      end
    end
  end
end
