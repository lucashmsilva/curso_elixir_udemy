defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :tapa},
        name: "Lucas"
      }

      assert expected_response == ExMon.create_player("Lucas", :tapa, :chute, :cura)
    end
  end

  describe "start_game/1" do
    test "starts a new game" do
      player = ExMon.create_player("Lucas", :tapa, :chute, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game has started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = ExMon.create_player("Lucas", :tapa, :chute, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:tapa)
        end)

      assert messages =~ "computer's turn"
      assert messages =~ "The Player attcked the Computer"
      assert messages =~ "player's turn"
      assert messages =~ "status: :continue"
    end

    test "returns error message when there is an invalid message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:bosta)
        end)

      assert messages =~ "\n ====== Invalid move bosta ====== \n\n"
    end
  end
end
