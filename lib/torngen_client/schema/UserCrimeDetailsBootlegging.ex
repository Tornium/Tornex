defmodule Torngen.Client.Schema.UserCrimeDetailsBootlegging do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:online_store, :dvds_copied, :dvd_sales]

  defstruct [
    :online_store,
    :dvds_copied,
    :dvd_sales
  ]

  @type t :: %__MODULE__{
          online_store: %{:visits => integer(), :sales => integer(), :earnings => integer(), :customers => integer()},
          dvds_copied: integer(),
          dvd_sales: %{
            :total => integer(),
            :thriller => integer(),
            :sci_fi => integer(),
            :"sci-fi" => integer(),
            :romance => integer(),
            :horror => integer(),
            :fantasy => integer(),
            :earnings => integer(),
            :drama => integer(),
            :comedy => integer(),
            :action => integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      online_store:
        Map.get(data, "online_store")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "customers" => {:static, :integer},
             "earnings" => {:static, :integer},
             "sales" => {:static, :integer},
             "visits" => {:static, :integer}
           }}
        ),
      dvds_copied: Map.get(data, "dvds_copied") |> Torngen.Client.Schema.parse({:static, :integer}),
      dvd_sales:
        Map.get(data, "dvd_sales")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "action" => {:static, :integer},
             "comedy" => {:static, :integer},
             "drama" => {:static, :integer},
             "earnings" => {:static, :integer},
             "fantasy" => {:static, :integer},
             "horror" => {:static, :integer},
             "romance" => {:static, :integer},
             "sci-fi" => {:static, :integer},
             "sci_fi" => {:static, :integer},
             "thriller" => {:static, :integer},
             "total" => {:static, :integer}
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

  defp validate_key?(:online_store, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "customers" => {:static, :integer},
         "earnings" => {:static, :integer},
         "sales" => {:static, :integer},
         "visits" => {:static, :integer}
       }}
    )
  end

  defp validate_key?(:dvds_copied, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:dvd_sales, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "action" => {:static, :integer},
         "comedy" => {:static, :integer},
         "drama" => {:static, :integer},
         "earnings" => {:static, :integer},
         "fantasy" => {:static, :integer},
         "horror" => {:static, :integer},
         "romance" => {:static, :integer},
         "sci-fi" => {:static, :integer},
         "sci_fi" => {:static, :integer},
         "thriller" => {:static, :integer},
         "total" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
