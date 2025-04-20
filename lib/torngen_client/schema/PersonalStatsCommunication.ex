defmodule Torngen.Client.Schema.PersonalStatsCommunication do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :communication
  ]

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
end
