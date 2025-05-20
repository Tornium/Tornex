defmodule Torngen.Client.Schema.PersonalStatsMissions do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :missions
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          missions: %{
            :missions => integer(),
            :credits => integer(),
            :contracts => %{:total => integer(), :duke => integer()}
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      missions:
        Map.get(data, "missions")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "contracts" => {:object, %{"duke" => {:static, :integer}, "total" => {:static, :integer}}},
             "credits" => {:static, :integer},
             "missions" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
