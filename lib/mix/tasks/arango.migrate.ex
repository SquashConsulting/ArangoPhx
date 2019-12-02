defmodule Mix.Tasks.Arango.Migrate do
  use Mix.Task

  @shortdoc "Migrates the DB"

  @impl true
  def run(_args) do
    pending_migrations()
    |> Enum.each(fn file_path ->
      {{:module, module, _, _}, _} =
        File.cwd!()
        |> Path.join("priv/repo/migrations")
        |> Path.join(file_path)
        |> Code.eval_file()

      case apply(module, :up, []) do
        :ok ->
          File.cwd!()
          |> Path.join("lib/mix/tasks/.migrated_versions")
          |> File.write!("#{timestamp(file_path)}\n", [:append])

          Mix.shell().info("Successfully Migrated #{file_path}")

        _ ->
          Mix.shell().error("Unable To Migrate #{file_path}")
      end
    end)
  end

  defp migrated_versions do
    File.cwd!()
    |> Path.join("lib/mix/tasks/.migrated_versions")
    |> File.stream!()
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {timestamp, _} -> timestamp end)
  end

  defp pending_migrations do
    File.cwd!()
    |> Path.join("priv/repo/migrations")
    |> File.ls!()
    |> Enum.filter(&(!String.starts_with?(&1, ".")))
    |> Enum.filter(fn file_path ->
      {parsed_timestamp, _} =
        file_path
        |> timestamp()
        |> Integer.parse()

      parsed_timestamp not in migrated_versions()
    end)
    |> Enum.sort(fn path1, path2 ->
      timestamp(path1) <= timestamp(path2)
    end)
  end

  defp timestamp(path) do
    path
    |> String.split("_")
    |> hd()
  end
end
