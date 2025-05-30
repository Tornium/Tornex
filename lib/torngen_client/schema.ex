defmodule Torngen.Client.Schema do
  @moduledoc false

  require Logger

  @doc """
  Parse an API response or response fragment into the schema.
  """
  @callback parse(map() | list()) :: any()

  @doc """
  Validate an API response or response fragment for a schema.
  """
  @callback validate?(any()) :: boolean()

  @spec parse(value :: any(), type :: module() | tuple()) :: any()
  def parse(value, type) when is_atom(type) do
    # When the type is an atom, the atom can be assumed to be the module referenced
    # Other types will be modules that will have to be parsed in-line

    Kernel.apply(type, :parse, [value])
  end

  def parse(value, {:object, pair_types}) do
    try do
      pair_types
      |> Enum.map(fn {key, type} -> {key, parse(Map.get(value, key), type)} end)
      |> Map.new()
    rescue
      _ -> nil
    end
  end

  def parse(value, {:array, type}) do
    value
    |> Enum.map(fn individual_value -> parse(individual_value, type) end)
  end

  def parse(value, {:one_of, types}) do
    valid_type = Enum.find(types, fn type -> validate?(value, type) end)

    case valid_type do
      nil -> nil
      _ -> parse(value, valid_type)
    end
  end

  def parse(value, {:all_of, types}) do
    types
    |> Enum.map(fn type -> {type, parse(value, type)} end)
    |> Map.new()
  end

  def parse(value, {:static, type}) do
    if validate?(value, {:static, type}) do
      value
    else
      nil
    end
  end

  def parse(_value, type) do
    Logger.warning("Unhandled type `#{inspect(type)}`")
    nil
  end

  @spec validate?(value :: any(), type :: module() | tuple()) :: boolean()
  def validate?(value, type) when is_atom(type) do
    # See reasoning in parse/2

    try do
      Kernel.apply(type, :validate?, [value])
    rescue
      _ -> false
    end
  end

  def validate?(value, {:array, type}) when is_list(value) do
    value
    |> Enum.map(fn individual_value -> validate?(individual_value, type) end)
    |> Enum.all?()
  end

  def validate?(value, {:static, :string}) when is_binary(value), do: true
  def validate?(value, {:static, :number}) when is_integer(value) or is_float(value), do: true
  def validate?(value, {:static, :integer}) when is_integer(value), do: true
  def validate?(value, {:static, :boolean}) when is_boolean(value), do: true
  def validate?(value, {:static, :null}) when is_nil(value), do: true

  def validate?(_value, _type), do: false
end
