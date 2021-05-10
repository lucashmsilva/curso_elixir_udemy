defmodule ExMon.Game.Status do
  def print_round_message(%{status: :started} = info) do
    IO.puts("\n ====== The game has started ====== \n")
    IO.inspect(info)
    IO.puts("---------------------")
  end

  def print_round_message(%{status: :game_over} = info) do
    IO.puts("\n ====== Game Over ====== \n")
    IO.inspect(info)
    IO.puts("---------------------")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("\n ====== It's #{player}'s turn ====== \n")
    IO.inspect(info)
    IO.puts("---------------------")
  end

  def print_worng_move(move) do
    IO.puts("\n ====== Invalid move #{move} ====== \n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n ====== The Player attcked the Computer, dealing #{damage} damage ====== \n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n ====== The Computer attcked the Player, dealing #{damage} damage ====== \n")
  end

  def print_move_message(player, :heal, life) do
    IO.puts("\n ====== The #{player} healled itself to #{life} life points ====== \n")
  end
end
