# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GameApi.Repo.insert!(%GameApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias GameApi.Repo
alias GameApi.Directory.Game
Repo.insert! %Game { data: "data1"}
Repo.insert! %Game { data: "data2"}
Repo.insert! %Game { data: "data3"}
Repo.insert! %Game { data: "data4"}
