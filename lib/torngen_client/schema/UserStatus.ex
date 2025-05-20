defmodule Torngen.Client.Schema.UserStatus do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :until,
    :state,
    :details,
    :description
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          until: nil | integer(),
          state: String.t(),
          details: nil | String.t(),
          description: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      until: Map.get(data, "until") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      state: Map.get(data, "state") |> Torngen.Client.Schema.parse({:static, :string}),
      details: Map.get(data, "details") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      description: Map.get(data, "description") |> Torngen.Client.Schema.parse({:static, :string})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
