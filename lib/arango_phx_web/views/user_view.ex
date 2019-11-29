defmodule ArangoPhxWeb.UserView do
  use ArangoPhxWeb, :view

  alias ArangoPhxWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user["_key"],
      email: user["email"],
      username: user["username"]
    }
  end

  def render("custom.json", %{result: result}) do
    %{data: result}
  end
end
