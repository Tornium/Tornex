defmodule Torngen.Client.Schema.UserCrimeDetailsBootlegging do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      online_store:
        Map.get(data, "online_store")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "customers" => {:static, :integer},
             "earnings" => {:static, :integer},
             "sales" => {:static, :integer},
             "visits" => {:static, :integer}
           }}
        ),
      dvds_copied: Map.get(data, "dvds_copied") |> Torngen.Client.Schema.parse({:static, :integer}),
      dvd_sales:
        Map.get(data, "dvd_sales")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "action" => {:static, :integer},
             "comedy" => {:static, :integer},
             "drama" => {:static, :integer},
             "earnings" => {:static, :integer},
             "fantasy" => {:static, :integer},
             "horror" => {:static, :integer},
             "romance" => {:static, :integer},
             "sci-fi" => {:static, :integer},
             "sci_fi" => {:static, :integer},
             "thriller" => {:static, :integer},
             "total" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
