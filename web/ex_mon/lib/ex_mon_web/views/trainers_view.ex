defmodule ExMonWeb.TrainersView do
  use ExMonWeb, :view

  def render("create.json", %{
    trainer: %ExMon.Trainer{id: id, name: name, inserted_at: inserted_at},
    token: token
  })  do
    %{
      messsage: "Trainer Created",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      },
      token: token
    }
  end


  def render("sign_in.json", %{token: token})  do
    %{token: token}
  end

  def render("show.json", %{trainer: %ExMon.Trainer{id: id, name: name, inserted_at: inserted_at}})  do
    %{
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end

  def render("update.json", %{trainer: %ExMon.Trainer{id: id, name: name, inserted_at: inserted_at, updated_at: updated_at}})  do
    %{
      messsage: "Trainer Updated",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end
end
