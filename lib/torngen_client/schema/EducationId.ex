defmodule Torngen.Client.Schema.EducationId do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  @type t :: integer()

  @impl true
  def parse(value) do
    if validate?(value) do
      value
    else
      nil
    end
  end

  @impl true
  def validate?(value), do: Torngen.Client.Schema.validate?(value, {:static, :integer})
end
