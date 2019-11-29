defmodule ArangoPhx.Repo do
  @otp_app :arango_phx

  def child_spec(opts \\ []) do
    opts
    |> config()
    |> Arangox.child_spec()
  end

  def config(opts \\ []) do
    Application.get_env(@otp_app, __MODULE__, [])
    |> Keyword.merge(opts)
    |> Keyword.merge(otp_app: @otp_app, name: __MODULE__)
  end

  def all(struct, _opts \\ []) do
    {:ok, result} =
      query("""
      FOR doc IN #{collection(struct)}
        RETURN doc
      """)

    result
  end

  def get(struct, id, _opts \\ []) do
    case Arangox.get(__MODULE__, "/_api/document/#{collection(struct)}/#{id}") do
      {:ok, _, %{body: body}} -> {:ok, body}
      {:error, %{status: status}} -> {:error, status}
    end
  end

  def insert(struct, _opts \\ []) do
    document =
      struct
      |> Map.from_struct()
      |> Map.get(:changes)

    case Arangox.post(
           __MODULE__,
           "/_api/document/#{collection(struct)}?returnNew=true",
           document
         ) do
      {:ok, _, %{body: body}} -> {:ok, body["new"]}
      {:error, %{status: status}} -> {:error, status}
    end
  end

  def update(struct, id, _opts \\ []) do
    document =
      struct
      |> Map.from_struct()
      |> Map.get(:changes)

    case Arangox.patch(
           __MODULE__,
           "/_api/document/#{collection(struct)}/#{id}?returnNew=true",
           document
         ) do
      {:ok, _, %{body: body}} -> {:ok, body["new"]}
      {:error, %{status: status}} -> {:error, status}
    end
  end

  def delete(struct, id, _opts \\ []) do
    case Arangox.delete(__MODULE__, "/_api/document/#{collection(struct)}/#{id}") do
      {:ok, _, _} -> :ok
      {:error, %{status: status}} -> {:error, status}
    end
  end

  def query(query_string) do
    Arangox.transaction(__MODULE__, fn cursor ->
      stream = Arangox.cursor(cursor, query_string)

      Enum.reduce(stream, [], fn resp, acc ->
        acc ++ resp.body["result"]
      end)
    end)
  end

  defp collection(%Ecto.Changeset{} = struct), do: struct.data.__meta__.source
  defp collection(struct), do: struct.__struct__.__meta__.source
end
