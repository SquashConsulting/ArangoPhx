defmodule Mix.Tasks.Arango.Gen.Migration do
  use Mix.Task

  import Mix.Generator
  import Macro, only: [camelize: 1, underscore: 1]

  @shortdoc "Generates a new migration for the ArangoPhx repo"

  @switches [
    no_compile: :boolean,
    no_deps_check: :boolean
  ]

  @impl true
  def run(args) do
    case OptionParser.parse!(args, strict: @switches) do
      {_, [name]} ->
        path = Path.join(priv_repo_path(), "migrations")
        base_name = "#{underscore(name)}.exs"
        file = Path.join(path, "#{timestamp()}_#{base_name}")

        unless File.dir?(path), do: create_directory(path)

        fuzzy_path = Path.join(path, "*_#{base_name}")

        if Path.wildcard(fuzzy_path) != [] do
          Mix.raise(
            "migration can't be created, there is already a migration file with name #{name}."
          )
        end

        assigns = [
          mod: Module.concat([ArangoPhx.Repo, Migrations, camelize(name)])
        ]

        create_file(file, migration_template(assigns))

        file

      {_, _} ->
        Mix.raise(
          "expected arango.gen.migration to receive the migration file name, " <>
            "got: #{inspect(Enum.join(args, " "))}"
        )
    end
  end

  defp priv_repo_path do
    app = Keyword.fetch!(ArangoPhx.Repo.config(), :otp_app)
    Path.join(Mix.Project.deps_paths()[app] || File.cwd!(), "priv/repo")
  end

  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end

  defp pad(i) when i < 10, do: <<?0, ?0 + i>>
  defp pad(i), do: to_string(i)

  embed_template(:migration, """
  defmodule <%= inspect @mod %> do
    alias ArangoPhx.Repo

    def up do
    end

    def down do
    end
  end
  """)
end
