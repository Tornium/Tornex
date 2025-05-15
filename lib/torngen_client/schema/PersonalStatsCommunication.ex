defmodule Torngen.Client.Schema.PersonalStatsCommunication do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :communication
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          communication: %{
            :personals => integer(),
            :mails_sent => %{
              :total => integer(),
              :spouse => integer(),
              :friends => integer(),
              :faction => integer(),
              :colleagues => integer()
            },
            :classified_ads => integer()
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      communication: Map.get(data, "communication")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
