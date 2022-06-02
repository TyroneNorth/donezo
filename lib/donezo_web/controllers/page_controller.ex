defmodule DonezoWeb.PageController do
  use DonezoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
