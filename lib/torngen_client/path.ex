defmodule Torngen.Client.Path do
  defmacro defparameter(args1, args2, do: body) do
    quote do
      @parameter_keys unquote(args1)
      def parameter(unquote(args1), unquote(args2)) do
        unquote(body)
      end
    end
  end

  @doc """
  Gets the path for a request against a path in the specification.
  """
  @callback path() :: String.t()

  @callback path_selection() :: {String.t(), String.t() | nil}

  @callback parameters() :: [atom()]

  @doc """
  Get the type of parameter.
  """
  @callback parameter(atom(), any()) :: {Torngen.Spec.Parameter.parameter_locations(), atom(), term()}
  
  @optional_callbacks parameter: 2

  def path_selection(path) do
    path
    |> String.split("/")
    |> do_path_selection()
  end

  defp do_path_selection(path_sections) when Kernel.length(path_sections) == 3 do
    # eg /faction/{id}/basic
    path =
      path_sections
      |> Enum.slice(0..1)
      |> Enum.join("/")

    {path, Enum.at(path_sections, -1)}
  end

  defp do_path_selection(path_sections) when Kernel.length(path_sections) == 2 do
    # eg /faction/applications
    {Enum.at(path_sections, 0), Enum.at(path_sections, 1)}
  end

  defp do_path_selection(path_sections) when Kernel.length(path_sections) == 1 do
    # eg /faction
    {Enum.at(path_sections, 0), nil}
  end
end
