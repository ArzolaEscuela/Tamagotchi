defmodule GameApiWeb.DefaultController do
  use GameApiWeb, :controller

  def index(conn, _params) do
    text conn, "Tamagotchi json api"
  end
end
