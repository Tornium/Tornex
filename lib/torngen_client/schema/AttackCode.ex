defmodule Torngen.Client.Schema.AttackCode do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @impl true
  def parse(value) do
    if validate?(value) do
      value
    else
      nil
    end
  end

  @impl true
  def validate?(value), do: Torngen.Client.Schema.validate?(value, {:static, :string})
end
