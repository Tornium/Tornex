defmodule Torngen.Client.Schema.TornItemWeaponDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :stealth_level,
    :mods,
    :category,
    :base_stats,
    :ammo
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          stealth_level: integer() | float(),
          mods: [Torngen.Client.Schema.ItemModId.t()],
          category: Torngen.Client.Schema.TornItemWeaponCategoryEnum.t(),
          base_stats: Torngen.Client.Schema.TornItemBaseStats.t(),
          ammo:
            nil
            | %{
                :rate_of_fire => %{:minimum => integer(), :maximum => integer()},
                :name => String.t(),
                :magazine_rounds => integer(),
                :id => Torngen.Client.Schema.AmmoId.t()
              }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stealth_level: Map.get(data, "stealth_level") |> Torngen.Client.Schema.parse({:static, :number}),
      mods: Map.get(data, "mods") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ItemModId}),
      category:
        Map.get(data, "category") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemWeaponCategoryEnum),
      base_stats: Map.get(data, "base_stats") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemBaseStats),
      ammo:
        Map.get(data, "ammo")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             static: :null,
             object: %{
               "id" => Torngen.Client.Schema.AmmoId,
               "magazine_rounds" => {:static, :integer},
               "name" => {:static, :string},
               "rate_of_fire" => {:object, %{"maximum" => {:static, :integer}, "minimum" => {:static, :integer}}}
             }
           ]}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
