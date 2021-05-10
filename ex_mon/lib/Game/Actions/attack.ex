defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game
  alias ExMon.Game.Status

  @move_avg_power 18..25
  @move_rnd_power 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_power(move)

    opponent
    |> Game.fetch_player_data()
    |> Map.get(:life)
    |> calculate_total_life(damage)
    |> update_opponent_life(opponent, damage)
  end

  def calculate_power(:move_avg), do: Enum.random(@move_avg_power)
  def calculate_power(:move_rnd), do: Enum.random(@move_rnd_power)

  def calculate_total_life(life, damage) when life - damage < 0, do: 0
  def calculate_total_life(life, damage), do: life - damage

  def update_opponent_life(life, opponent, damage) do
    opponent
    |> Game.fetch_player_data()
    |> Map.put(:life, life)
    |> update_game(opponent, damage)
  end

  def update_game(updated_player_data, opponent, damage) do
    Game.info()
    |> Map.put(opponent, updated_player_data)
    |> Game.update()

    Status.print_move_message(opponent, :attack, damage)
  end
end
