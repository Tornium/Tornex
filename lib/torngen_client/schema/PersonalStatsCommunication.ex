defmodule Torngen.Client.Schema.PersonalStatsCommunication do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      communication:
        Map.get(data, "communication")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "classified_ads" => {:static, :integer},
             "mails_sent" =>
               {:object,
                %{
                  "colleagues" => {:static, :integer},
                  "faction" => {:static, :integer},
                  "friends" => {:static, :integer},
                  "spouse" => {:static, :integer},
                  "total" => {:static, :integer}
                }},
             "personals" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
