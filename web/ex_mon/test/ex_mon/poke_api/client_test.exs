defmodule ExMon.PokeApi.ClietTest  do
  use ExUnit.Case
  import Tesla.Mock

  alias ExMon.PokeApi.Client

  @base_url "https://pokeapi.co/api/v2/pokemon"

  describe "get_pockemon/1" do
    test "when there is a pokmeon with the given name, returns the pokemon" do
      body = %{"name" => "pikachu", "weigth" => 60, "types" => ["electric"]}

      mock(fn %{method: :get, url: @base_url <> "/pikachu"} ->
        %Tesla.Env{status: 200, body: body}
      end)

      response = Client.get_pokemon("pikachu")

      expected_response = {:ok, body}

      assert response == expected_response
    end

    test "when there no a pokmeon with the given name, returns an error" do
      mock(fn %{method: :get, url: @base_url <> "/banana"} ->
        %Tesla.Env{status: 404}
      end)

      response = Client.get_pokemon("banana")

      expected_response = {:error, "Pokemon not found!"}

      assert response == expected_response
    end

    test "when there is an expected response, returns an error" do
      mock(fn %{method: :get, url: @base_url <> "/vai_dar_timeout"} ->
        {:error, :timeout}
      end)

      response = Client.get_pokemon("vai_dar_timeout")

      expected_response = {:error, :timeout}

      assert response == expected_response
    end
  end

end
