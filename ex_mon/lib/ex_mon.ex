defmodule ExMon do
  alias ExMon.{Player, Game}
  alias Game.{Status, Actions}

  @computer_name "Bot"
  @computer_moves [:move_avg, :move_rnd, :move_heal]
  @players [:computer, :player]

  def create_player(name, move_rnd, move_avg, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end

  def start_game(player) do
    starting_player = draw_starting_player()

    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player, starting_player)

    Status.print_round_message(Game.info())
    make_first_play(starting_player)
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp draw_starting_player, do: Enum.random(@players)

  defp make_first_play(first_player) when first_player == :computer,
    do: computer_move(Game.info())

  defp make_first_play(_), do: :ok

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_status, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end

  defp do_move({:error, move}), do: Status.print_worng_move(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: game_status, computer: %{life: computer_life}})
       when game_status in [:started, :continue] do
    move = {:ok, draw_computer_action(computer_life)}
    do_move(move)
  end

  defp computer_move(_), do: :ok

  # 60% chance of the computer healling itself when life is bellow 40 life points
  defp draw_computer_action(computer_life) when computer_life <= 40,
    do: Enum.random([:move_heal, :move_heal | @computer_moves])

  defp draw_computer_action(_), do: Enum.random(@computer_moves)
end
