defmodule DonezoWeb.TaskController do
  use DonezoWeb, :controller

  alias Donezo.Notes
  alias Donezo.Notes.Task

  def index(conn, _params) do
    tasks = Notes.list_tasks(conn.assigns.current_user.id)
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Notes.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    user_id = conn.assigns.current_user.id
    task_params = Map.put_new(task_params, "user_id", user_id)
    case Notes.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.user_task_path(conn, :show, task.user_id, task.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Notes.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Notes.get_task!(id)
    changeset = Notes.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task_params = Map.put_new(task_params, "items", nil)
    task = Notes.get_task!(id)

    case Notes.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.user_task_path(conn, :show, task.user_id, task.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Notes.get_task!(id)
    {:ok, _task} = Notes.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.user_task_path(conn, :index, task.user_id))
  end
end
