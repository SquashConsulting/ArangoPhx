# ArangoPhx - Phoenix Template Project with ArangoDB support

### To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Run ArangoDb on `http://localhost:8529/`
- Create a dev db and name it `arango_phx_dev` or change the db name in `config/dev.exs`
- Start Phoenix endpoint with `mix phx.server`

### Repo

`ArangoPhx.Repo` uses [ArangoX](https://github.com/ArangoDB-Community/arangox) and has basic CRUD functionality plus a function for custom queries.

### Available functions

You can use:

- [x] `Ecto.Schema`
- [x] `Ecto.Changeset`

like you used to with a Phoenix + PostgreSQL project.

### Mix Tasks

- `mix arango.gen.migration` - Generates a new migration for the ArangoPhx repo
- `mix arango.migrate` - Runs all pending migrations.

### TODO

- [x] Generate Migration
- [x] Run Migration
- [ ] Run Seeds
- [ ] Create a Fallback Controller
