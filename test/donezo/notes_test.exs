defmodule Donezo.NotesTest do
  use Donezo.DataCase

  alias Donezo.Notes

  describe "tasks" do
    alias Donezo.Notes.Task

    import Donezo.NotesFixtures

    @invalid_attrs %{items: nil, title: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Notes.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Notes.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{items: [], title: "some title"}

      assert {:ok, %Task{} = task} = Notes.create_task(valid_attrs)
      assert task.items == []
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notes.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{items: [], title: "some updated title"}

      assert {:ok, %Task{} = task} = Notes.update_task(task, update_attrs)
      assert task.items == []
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Notes.update_task(task, @invalid_attrs)
      assert task == Notes.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Notes.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Notes.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Notes.change_task(task)
    end
  end
end
