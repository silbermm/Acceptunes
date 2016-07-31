ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Acceptunes.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Acceptunes.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Acceptunes.Repo)

