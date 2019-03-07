defmodule IdeaPortal.Accounts do
  @moduledoc """
  Context for user accounts
  """

  alias IdeaPortal.Accounts.User
  alias IdeaPortal.Repo

  @doc """
  Register an account
  """
  def register(params) do
    %User{}
    |> User.create_changeset(params)
    |> Repo.insert()
  end
end
