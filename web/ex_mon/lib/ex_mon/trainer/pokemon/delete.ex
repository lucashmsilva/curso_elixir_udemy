defmodule ExMon.Trainer.Pokemon.Delete do
  alias ExMon.{Trainer.Pokemon, Repo}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid Id Format"}
      {:ok, uuid} -> delete_pokemon(uuid)
    end
  end

  defp delete_pokemon(uuid) do
    case fetch_pokemon(uuid) do
      nil -> {:error, "Pokemon not found"}
      porkemon -> Repo.delete(porkemon)
    end
  end

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
