defmodule Donezo.NotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Donezo.Notes` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        items: [],
        title: "some title"
      })
      |> Donezo.Notes.create_task()

    task
  end
end
