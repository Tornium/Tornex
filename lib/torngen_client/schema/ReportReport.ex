defmodule Torngen.Client.Schema.ReportReport do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:report]

  defstruct [
    :report
  ]

  @type t :: %__MODULE__{
          report:
            Torngen.Client.Schema.ReportInvestment.t()
            | Torngen.Client.Schema.ReportAnonymousBounties.t()
            | Torngen.Client.Schema.ReportStockAnalysis.t()
            | Torngen.Client.Schema.ReportTrueLevel.t()
            | Torngen.Client.Schema.ReportCompanyFinancials.t()
            | Torngen.Client.Schema.ReportFriendOrFoe.t()
            | Torngen.Client.Schema.ReportHistory.t()
            | Torngen.Client.Schema.ReportMostWanted.t()
            | Torngen.Client.Schema.ReportStats.t()
            | Torngen.Client.Schema.ReportMoney.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      report:
        data
        |> Map.get("report")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             Torngen.Client.Schema.ReportInvestment,
             Torngen.Client.Schema.ReportAnonymousBounties,
             Torngen.Client.Schema.ReportStockAnalysis,
             Torngen.Client.Schema.ReportTrueLevel,
             Torngen.Client.Schema.ReportCompanyFinancials,
             Torngen.Client.Schema.ReportFriendOrFoe,
             Torngen.Client.Schema.ReportHistory,
             Torngen.Client.Schema.ReportMostWanted,
             Torngen.Client.Schema.ReportStats,
             Torngen.Client.Schema.ReportMoney
           ]}
        )
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

  defp validate_key?(:report, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         Torngen.Client.Schema.ReportInvestment,
         Torngen.Client.Schema.ReportAnonymousBounties,
         Torngen.Client.Schema.ReportStockAnalysis,
         Torngen.Client.Schema.ReportTrueLevel,
         Torngen.Client.Schema.ReportCompanyFinancials,
         Torngen.Client.Schema.ReportFriendOrFoe,
         Torngen.Client.Schema.ReportHistory,
         Torngen.Client.Schema.ReportMostWanted,
         Torngen.Client.Schema.ReportStats,
         Torngen.Client.Schema.ReportMoney
       ]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
