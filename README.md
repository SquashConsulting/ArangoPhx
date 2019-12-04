# ArangoPhx - Phoenix Template Project with ArangoDB support

### To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Run ArangoDb on `http://localhost:8529/`
- Create a dev db and name it `arango_phx_dev` or change the db name in `config/dev.exs`
- Start Phoenix endpoint with `mix phx.server`

### Repo

`ArangoPhx.Repo` uses [ArangoX](https://github.com/ArangoDB-Community/arangox) and has basic CRUD functionality plus a function for custom queries.

### Available functions

`Ecto.Schema` and `Ecto.Changeset` can be used like you used to with a Phoenix + PostgreSQL project.

`Arango.Migrate` and `Arango.Gen.Migration` can be used to generate migration files, migrate, and rollback them.

`ArangoPhx.Repo` is custom Repo that exposes basic functionality to talk to [Arango DB](https://www.arangodb.com/)

### Mix Tasks

- `mix arango.gen.migration` - Generates a new migration for the ArangoPhx repo
- `mix arango.migrate` or `mix arango.migrate -d up` - Runs all pending migrations.
- `mix arango.migrate down` or `mix arango.migrate -d down` - Rolls last migration back.

### TODO

Find the Project Board Here: https://github.com/rasjonell/ArangoPhx/projects/1

- [Squash Migrations](https://github.com/rasjonell/ArangoPhx/issues/2)
- [Generate Resources](https://github.com/rasjonell/ArangoPhx/issues/3)
- [Create a Fallback Controller](https://github.com/rasjonell/ArangoPhx/issues/4)
