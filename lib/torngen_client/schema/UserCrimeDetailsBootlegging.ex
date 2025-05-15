defmodule Torngen.Client.Schema.UserCrimeDetailsBootlegging do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :online_store,
    :dvds_copied,
    :dvd_sales
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          online_store: %{:visits => integer(), :sales => integer(), :earnings => integer(), :customers => integer()},
          dvds_copied: integer(),
          dvd_sales: %{
            :total => integer(),
            :thriller => integer(),
            :sci_fi => integer(),
            :"sci-fi" => integer(),
            :romance => integer(),
            :horror => integer(),
            :fantasy => integer(),
            :earnings => integer(),
            :drama => integer(),
            :comedy => integer(),
            :action => integer()
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      online_store: Map.get(data, "online_store"),
      dvds_copied: Map.get(data, "dvds_copied"),
      dvd_sales: Map.get(data, "dvd_sales")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
