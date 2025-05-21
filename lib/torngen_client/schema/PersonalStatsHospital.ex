defmodule Torngen.Client.Schema.PersonalStatsHospital do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:hospital]

  defstruct [
    :hospital
  ]

  @type t :: %__MODULE__{
          hospital: %{
            :times_hospitalized => integer(),
            :reviving => %{:skill => integer(), :revives_received => integer(), :revives => integer()},
            :medical_items_used => integer(),
            :blood_withdrawn => integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hospital:
        data
        |> Map.get("hospital")
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
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:hospital, value) do
    Torngen.Client.Schema.validate?(
      value,
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
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
