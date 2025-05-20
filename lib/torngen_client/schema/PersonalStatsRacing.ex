defmodule Torngen.Client.Schema.PersonalStatsRacing do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :racing
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          racing: %{:skill => integer(), :races => %{:won => integer(), :entered => integer()}, :points => integer()}
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      racing:
        Map.get(data, "racing")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "points" => {:static, :integer},
             "races" => {:object, %{"entered" => {:static, :integer}, "won" => {:static, :integer}}},
             "skill" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
