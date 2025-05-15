defmodule Torngen.Client.Schema.PersonalStatsDrugs do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :drugs
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          drugs: %{
            :xanax => integer(),
            :vicodin => integer(),
            :total => integer(),
            :speed => integer(),
            :shrooms => integer(),
            :rehabilitations => %{:fees => integer(), :amount => integer()},
            :pcp => integer(),
            :overdoses => integer(),
            :opium => integer(),
            :lsd => integer(),
            :ketamine => integer(),
            :ecstasy => integer(),
            :cannabis => integer()
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      drugs: Map.get(data, "drugs")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
