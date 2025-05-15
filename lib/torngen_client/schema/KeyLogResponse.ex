defmodule Torngen.Client.Schema.KeyLogResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :log
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          log: [
            %{
              :type => String.t(),
              :timestamp => integer(),
              :selections => String.t(),
              :ip => String.t(),
              :id => nil | integer()
            }
          ]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      log: Map.get(data, "log")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
