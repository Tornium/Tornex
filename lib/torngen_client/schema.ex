defmodule Torngen.Client.Schema do
  @type t :: nil
  # TODO: Add fallback type

  @callback parse() :: t()
  # TODO: Add documentation
end
