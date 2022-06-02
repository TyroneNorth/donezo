defmodule Donezo.Notes.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :items, {:array, :string}
    field :title, :string
    belongs_to :user, Donezo.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :items, :user_id])
    |> validate_required([:title, :items, :user_id])
    |> assoc_constraint(:user)

  end
end
