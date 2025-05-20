defmodule Torngen.Client.Schema.KeyLogResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:log]

  defstruct [
    :log
  ]

  @type t :: %__MODULE__{
          log: [
            %{
              :type => String.t(),
              :timestamp => integer(),
              :selections => String.t(),
              :ip => String.t(),
              :id => nil | integer(),
              :comment => nil | String.t()
            }
          ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      log:
        Map.get(data, "log")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              "comment" => {:one_of, [static: :null, static: :string]},
              "id" => {:one_of, [static: :null, static: :integer]},
              "ip" => {:static, :string},
              "selections" => {:static, :string},
              "timestamp" => {:static, :integer},
              "type" => {:static, :string}
            }}}
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

  defp validate_key(:log, value) do
    Torngen.Client.Schema.validate(
      value,
      {:array,
       {:object,
        %{
          "comment" => {:one_of, [static: :null, static: :string]},
          "id" => {:one_of, [static: :null, static: :integer]},
          "ip" => {:static, :string},
          "selections" => {:static, :string},
          "timestamp" => {:static, :integer},
          "type" => {:static, :string}
        }}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
