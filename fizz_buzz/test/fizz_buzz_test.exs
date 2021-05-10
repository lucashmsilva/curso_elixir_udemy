defmodule FizzBuzzTest do
  use ExUnit.Case
  import Mock


  describe "build/1" do
    test "when a valid file is provided, returns the converted list" do
      expeted_response = {:ok, [1, 2, :fizz, 4, :fizzbuzz]}
      with_mock File, [read: fn "valid.file" -> {:ok, "1,2,3,4,15"} end] do
        assert FizzBuzz.build("valid.file") == expeted_response
      end
    end

    test "when a invalid file is provided, returns an error" do
      expeted_response = {:error, "Error reading the file: enoent"}
      with_mock File, [read: fn "invalid.file" -> {:error, :enoent} end] do
        assert FizzBuzz.build("invalid.file") == expeted_response
      end
    end
  end
end
