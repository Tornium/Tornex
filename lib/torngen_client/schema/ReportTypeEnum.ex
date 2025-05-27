defmodule Torngen.Client.Schema.ReportTypeEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "mostwanted",
    "money",
    "stats",
    "references",
    "friendorfoe",
    "companyfinancials",
    "truelevel",
    "stockanalysis",
    "anonymousbounties",
    "investment"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of ReportTypeEnum")
      nil
    end
  end
end
