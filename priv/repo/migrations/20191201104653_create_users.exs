defmodule ArangoPhx.Repo.Migrations.CreateUsers do
  alias ArangoPhx.Repo

  def up do
    Repo.create_document("users")
  end

  def down do
    Repo.remove_document("users")
  end
end
