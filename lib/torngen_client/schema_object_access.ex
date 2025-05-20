defmodule Torngen.Client.SchemaObjectAccess do
  @moduledoc false

  defmacro __using__(opts) do
    quote do
      require Logger

      @behaviour Access

      def fetch(%{} = struct, key) do
        deprecated_keys = Keyword.get(unquote(opts), :deprecated, [])

        if Enum.member?(deprecated_keys, key) do
          Logger.notice("Object key `#{key}` of `#{unquote(__MODULE__) |> inspect()}` is deprecated")
        end

        case Map.fetch(Map.from_struct(struct), key) do
          :error -> :error
          {:ok, value} -> {:ok, value}
        end
      end

      def get_and_update(map, key, value), do: Map.get_and_update(map, key, value)

      def pop(data, key), do: Map.pop(data, key)
    end
  end
end
