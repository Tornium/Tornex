defmodule Torngen.Client.Schema.KeyLogResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :log
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          log: [
            %{
              :type => String.t(),
              :timestamp => integer(),
              :selections => String.t(),
              :ip => String.t(),
              :id => nil | integer()
            }
          ]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      log:
        Map.get(data, "log")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
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
end
