defmodule IdeaPortal.Timeline.Event do
  @moduledoc """
  Timeline event schema
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias IdeaPortal.Challenges.Challenge

  @type t :: %__MODULE__{}

  schema "timeline_events" do
    field(:title, :string)
    field(:body, :string)
    field(:occurs_on, :date)

    belongs_to(:challenge, Challenge)

    timestamps()
  end

  def create_changeset(struct, params) do
    struct
    |> cast(params, [:title, :body, :occurs_on])
    |> validate_required([:title, :occurs_on])
    |> foreign_key_constraint(:challenge_id)
  end

  def update_changeset(struct, params) do
    create_changeset(struct, params)
  end
end
