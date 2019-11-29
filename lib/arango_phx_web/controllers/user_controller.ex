defmodule ArangoPhxWeb.UserController do
  use ArangoPhxWeb, :controller

  alias ArangoPhx.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()

    conn
    |> put_status(:ok)
    |> render("index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    case Accounts.get_user(id) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user)

      _ ->
        conn
        |> put_status(:not_found)
        |> text("not found")
    end
  end

  def create(conn, %{"user" => user}) do
    case Accounts.create_user(user) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user)

      {:error, status} ->
        conn
        |> put_status(status)
        |> text("Bad Request")
    end
  end

  def update(conn, %{"user" => user, "id" => id}) do
    case Accounts.update_user(id, user) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user)

      {:error, status} ->
        conn
        |> put_status(status)
        |> text("Bad Request")
    end
  end

  def delete(conn, %{"id" => id}) do
    case Accounts.delete_user(id) do
      :ok ->
        conn
        |> put_status(:ok)
        |> text("User Deleted")

      {:error, status} ->
        conn
        |> put_status(status)
        |> text("Not Found")
    end
  end

  def get_keys(conn, _params) do
    case Accounts.get_keys() do
      {:ok, result} ->
        conn
        |> put_status(:ok)
        |> render("custom.json", result: result)

      {:error, status} ->
        conn
        |> put_status(status)
        |> text("Bad Request")
    end
  end
end
