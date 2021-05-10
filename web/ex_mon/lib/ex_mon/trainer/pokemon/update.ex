defmodule ExMon.Trainer.Pokemon.Update do
  alias ExMon.{Trainer.Pokemon, Repo}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid Id Format"}
      {:ok, _uuid} -> update(uuid, params)
    end
  end

  defp update(uuid, params) do
    case fetch_pokemon(uuid) do
      nil -> {:error, "Pokemon not found"}
      pokemon -> udpate_pokemon(pokemon, params)
    end
  end

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)

  defp udpate_pokemon(pokemon, params) do
    pokemon
    |> Pokemon.update_changeset(params)
    |> Repo.update()
  end
end
