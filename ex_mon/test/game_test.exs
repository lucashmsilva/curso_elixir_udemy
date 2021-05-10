defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Player, Game}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Rafael", :chute, :soco, :cura)
      computer = Player.build("Rafael", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns current game state" do
      player = Player.build("Rafael", :chute, :soco, :cura)
      computer = Player.build("Rafael", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Rafael"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Rafael"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the updated game state" do
      player = Player.build("Rafael", :chute, :soco, :cura)
      computer = Player.build("Rafael", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Rafael"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Rafael"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %ExMon.Player{
          life: 54,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Rafael"
        },
        player: %ExMon.Player{
          life: 42,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Rafael"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)
      expected_response = %{new_state | turn: :computer, status: :continue}

      assert Game.info() == expected_response
    end
  end

  describe "player/0" do
    test "returns the player data" do
      player = Player.build("Rafael", :chute, :soco, :cura)
      computer = Player.build("Rafael", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Rafael"
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the current turn" do
      player = Player.build("Rafael", :chute, :soco, :cura)
      computer = Player.build("Rafael", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = :player

      assert expected_response == Game.turn()
    end
  end

  describe "fetch_player_data/1" do
    test "returns the data for the player passed as argument" do
      player = Player.build("Rafael", :chute, :soco, :cura)
      computer = Player.build("Rafael", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Rafael"
      }

      assert expected_response == Game.fetch_player_data(:computer)
    end
  end
end
