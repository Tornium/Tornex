defmodule Torngen.Client.Schema.ReportCompanyFinancials do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:wages, :employees, :balance]

  defstruct [
    :wages,
    :employees,
    :balance
  ]

  @type t :: %__MODULE__{
          wages: %{:lowest => integer(), :highest => integer(), :average => integer()},
          employees: integer(),
          balance: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      wages:
        data
        |> Map.get("wages")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{"average" => {:static, :integer}, "highest" => {:static, :integer}, "lowest" => {:static, :integer}}}
        ),
      employees: data |> Map.get("employees") |> Torngen.Client.Schema.parse({:static, :integer}),
      balance: data |> Map.get("balance") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:wages, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{"average" => {:static, :integer}, "highest" => {:static, :integer}, "lowest" => {:static, :integer}}}
    )
  end

  defp validate_key?(:employees, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:balance, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
