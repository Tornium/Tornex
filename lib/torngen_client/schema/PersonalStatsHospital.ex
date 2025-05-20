defmodule Torngen.Client.Schema.PersonalStatsHospital do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :hospital
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          hospital: %{
            :times_hospitalized => integer(),
            :reviving => %{:skill => integer(), :revives_received => integer(), :revives => integer()},
            :medical_items_used => integer(),
            :blood_withdrawn => integer()
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hospital:
        Map.get(data, "hospital")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "blood_withdrawn" => {:static, :integer},
             "medical_items_used" => {:static, :integer},
             "reviving" =>
               {:object,
                %{
                  "revives" => {:static, :integer},
                  "revives_received" => {:static, :integer},
                  "skill" => {:static, :integer}
                }},
             "times_hospitalized" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
