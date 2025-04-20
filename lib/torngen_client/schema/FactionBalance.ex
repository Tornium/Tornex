defmodule Torngen.Client.Schema.FactionBalance do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :members,
    :faction
  ]

  @type t :: %__MODULE__{
          members: [
            %{
              :username => String.t(),
              :points => integer(),
              :money => integer(),
              :id => Torngen.Client.Schema.UserId.t()
            }
          ],
          faction: %{:scope => integer(), :points => integer(), :money => integer()}
        }
end
