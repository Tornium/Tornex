defmodule Torngen.Client.Schema.PersonalStatsHospitalPopular do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :hospital
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          hospital: %{:reviving => %{:skill => integer(), :revives => integer()}, :medical_items_used => integer()}
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hospital: Map.get(data, "hospital")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
