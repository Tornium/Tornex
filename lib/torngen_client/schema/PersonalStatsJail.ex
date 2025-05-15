defmodule Torngen.Client.Schema.PersonalStatsJail do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :jail
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          jail: %{
            :times_jailed => integer(),
            :busts => %{:success => integer(), :fails => integer()},
            :bails => %{:fees => integer(), :amount => integer()}
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      jail: Map.get(data, "jail")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
