defmodule Torngen.Client.Schema.PersonalStatsJail do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      jail:
        Map.get(data, "jail")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "bails" => {:object, %{"amount" => {:static, :integer}, "fees" => {:static, :integer}}},
             "busts" => {:object, %{"fails" => {:static, :integer}, "success" => {:static, :integer}}},
             "times_jailed" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
