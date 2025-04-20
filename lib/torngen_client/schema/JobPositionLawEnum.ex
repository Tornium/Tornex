defmodule Torngen.Client.Schema.JobPositionLawEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionLawEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Law Student", "Paralegal", "Probate Lawyer", "Trial Lawyer", "Circuit Court Judge", "Federal Judge"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
