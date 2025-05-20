defmodule Torngen.Client.Schema do
  @callback parse(map() | list()) :: any()
  # TODO: Add documentation

  @callback validate(any()) :: boolean()
  # TODO: Add documentation

  @spec parse(value :: any(), type :: module() | tuple()) :: any()
  def parse(value, type) when is_atom(type) do
    # When the type is an atom, the atom can be assumed to be the module referenced
    # Other types will be modules that will have to be parsed in-line

    Kernel.apply(type, :parse, [value])
  end

  def parse(value, {:array, type}) do
    value
    |> Enum.map(fn individual_value -> parse(individual_value, type) end)
  end

  def parse(value, {:one_of, types}) do
    valid_type = Enum.find(types, fn type -> validate(value, type) end)

    case valid_type do
      nil -> nil
      _ -> parse(value, valid_type)
    end
  end

  def parse(value, {:static, type}) do
    # TODO: Validate type of value
    value
  end

  def parse(value, type) do
    IO.inspect(type, label: "Unhandled type")
    nil
  end

  @spec validate(value :: any(), type :: module() | tuple()) :: boolean()
  def validate(value, type) when is_atom(type) do
    # See reasoning in parse/2

    Kernel.apply(type, :validate, [value])
  end

  def validate(value, {:array, type}) when is_list(value) do
    value
    |> Enum.map(fn individual_value -> validate(individual_value, type) end)
    |> Enum.all?()
  end

  def validate(value, {:static, :string}) when is_binary(value), do: true
  def validate(value, {:string, :number}) when is_integer(value) or is_float(value), do: true
  def validate(value, {:static, :integer}) when is_integer(value), do: true
  def validate(value, {:string, :boolean}) when is_boolean(value), do: true
  def validate(value, {:static, :null}) when is_nil(value), do: true

  def validate(_value, _type), do: false
end
