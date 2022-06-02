defmodule DonezoWeb.UserController do
  use DonezoWeb, :controller


  alias Donezo.Accounts

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end


end
