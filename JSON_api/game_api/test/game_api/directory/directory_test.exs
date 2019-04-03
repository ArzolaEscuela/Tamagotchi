defmodule GameApi.DirectoryTest do
  use GameApi.DataCase

  alias GameApi.Directory

  describe "games" do
    alias GameApi.Directory.Game

    @valid_attrs %{data: "some data"}
    @update_attrs %{data: "some updated data"}
    @invalid_attrs %{data: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Directory.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Directory.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Directory.create_game(@valid_attrs)
      assert game.data == "some data"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, game} = Directory.update_game(game, @update_attrs)
      assert %Game{} = game
      assert game.data == "some updated data"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_game(game, @invalid_attrs)
      assert game == Directory.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Directory.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Directory.change_game(game)
    end
  end
end
