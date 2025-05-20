defmodule Torngen.Client.Schema.PersonalStatsBounties do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :bounties
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          bounties: %{
            :received => %{:value => integer(), :amount => integer()},
            :placed => %{:value => integer(), :amount => integer()},
            :collected => %{:value => integer(), :amount => integer()}
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      bounties:
        Map.get(data, "bounties")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "collected" => {:object, %{"amount" => {:static, :integer}, "value" => {:static, :integer}}},
             "placed" => {:object, %{"amount" => {:static, :integer}, "value" => {:static, :integer}}},
             "received" => {:object, %{"amount" => {:static, :integer}, "value" => {:static, :integer}}}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
