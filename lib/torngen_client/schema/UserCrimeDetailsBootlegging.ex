defmodule Torngen.Client.Schema.UserCrimeDetailsBootlegging do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :online_store,
    :dvds_copied,
    :dvd_sales
  ]

  @type t :: %__MODULE__{
          online_store: %{:visits => integer(), :sales => integer(), :earnings => integer(), :customers => integer()},
          dvds_copied: integer(),
          dvd_sales: %{
            :total => integer(),
            :thriller => integer(),
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
end
