defmodule Torngen.Client.Schema.PersonalStatsCommunication do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:communication]

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

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:communication, value) do
    Torngen.Client.Schema.validate(
      value,
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
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
