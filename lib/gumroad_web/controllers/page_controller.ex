defmodule GumroadWeb.PageController do
  use GumroadWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
