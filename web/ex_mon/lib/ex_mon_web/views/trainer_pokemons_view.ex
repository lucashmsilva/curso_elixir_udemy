defmodule ExMonWeb.TrainerPokemonsView do
  use ExMonWeb, :view
  alias ExMon.Trainer.Pokemon
  alias ExMon.Trainer

  def render("create.json", %{
      pokemon: %Pokemon{
        id: id,
        name: name,
        inserted_at: inserted_at,
        nickname: nickname,
        types: types,
        trainer_id: trainer_id,
        weight: weight
        }
      })  do
    %{
      messsage: "Pokemon created!!",
      pokemon: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        nickname: nickname,
        types: types,
        trainer_id: trainer_id,
        weight: weight
      }
    }
  end

  def render("show.json", %{
    pokemon: %Pokemon{
      id: id,
      name: name,
      inserted_at: inserted_at,
      nickname: nickname,
      types: types,
      weight: weight,
      trainer: %Trainer{
        id: trainer_id,
        name: trainer_name
      }
    }
  })  do
    %{
      messsage: "Pokemon created!!",
      pokemon: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        nickname: nickname,
        types: types,
        weight: weight,
        trainer: %{
          trainer_id: trainer_id ,
          trainer_name: trainer_name
        }
      }
    }
  end

  def render("update.json", %{
    pokemon: %Pokemon{
      id: id,
      name: name,
      inserted_at: inserted_at,
      nickname: nickname,
      types: types,
      trainer_id: trainer_id,
      weight: weight
      }
    })  do
  %{
    messsage: "Pokemon Updated!!",
    pokemon: %{
      id: id,
      name: name,
      inserted_at: inserted_at,
      nickname: nickname,
      types: types,
      trainer_id: trainer_id,
      weight: weight
    }
  }
end
end
