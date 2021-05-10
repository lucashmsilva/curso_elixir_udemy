defmodule ExMon.Trainer.Update do
  alias ExMon.{Trainer, Repo}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid Id Format"}
      {:ok, _uuid} -> update(uuid, params)
    end
  end

  defp update(uuid, params) do
    case fetch_trainer(uuid) do
      nil -> {:error, "Trainer not found"}
      trainer -> udpate_trainer(trainer, params)
    end
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)

  defp udpate_trainer(trainer, params) do
    trainer
    |> Trainer.changeset(params)
    |> Repo.update()
  end
end
