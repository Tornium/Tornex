defmodule Torngen.Client.Schema.PersonalStatsJail do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:jail]

  defstruct [
    :jail
  ]

  @type t :: %__MODULE__{
          jail: %{
            :times_jailed => integer(),
            :busts => %{:success => integer(), :fails => integer()},
            :bails => %{:fees => integer(), :amount => integer()}
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      jail:
        Map.get(data, "jail")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "bails" => {:object, %{"amount" => {:static, :integer}, "fees" => {:static, :integer}}},
             "busts" => {:object, %{"fails" => {:static, :integer}, "success" => {:static, :integer}}},
             "times_jailed" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:jail, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "bails" => {:object, %{"amount" => {:static, :integer}, "fees" => {:static, :integer}}},
         "busts" => {:object, %{"fails" => {:static, :integer}, "success" => {:static, :integer}}},
         "times_jailed" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
