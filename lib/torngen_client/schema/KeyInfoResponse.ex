defmodule Torngen.Client.Schema.KeyInfoResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :info
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          info: %{
            :selections => %{
              :user => [Torngen.Client.Schema.UserSelectionName.t()],
              :torn => [Torngen.Client.Schema.TornSelectionName.t()],
              :racing => [Torngen.Client.Schema.RacingSelectionName.t()],
              :property => [String.t()],
              :market => [Torngen.Client.Schema.MarketSelectionName.t()],
              :key => [Torngen.Client.Schema.KeySelectionName.t()],
              :forum => [Torngen.Client.Schema.ForumSelectionName.t()],
              :faction => [Torngen.Client.Schema.FactionSelectionName.t()],
              :company => [String.t()]
            },
            :access => %{
              :type => Torngen.Client.Schema.ApiKeyAccessTypeEnum.t(),
              :level => integer(),
              :faction => boolean(),
              :company => boolean()
            }
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      info: Map.get(data, "info")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
