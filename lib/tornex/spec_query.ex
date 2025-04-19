defmodule Tornex.SpecQuery do
  @moduledoc """
  The query struct containing API request data for API v2 requests.

  The `Tornex.SpecQuery` struct works against the OpenAPI specification for the Torn API v2. `Tornex.SpecQuery` can be used by `Tornex.API.torn_get/1` and `Tornex.Scheduler.Bucket.enqueue/1` to make API calls. The struct stores the required information to perform the API call. Alternatively, to make API calls without the OpenAPI specification use `Tornex.Query` instead.

  ## Preparing Query
  Create an empty using `new/0`. Use `put_path/2` and `put_parameter` to set up the query.

      query = Tornex.SpecQuery.new()
      Tornex.SpecQuery.put_path(query, Torngen.Client.Path.User.Id.Bounties)
      Tornex.SpecQuery.put_parameter(query, :id, 2383326)

  ## Making Query
  """

  @host Application.compile_env(:tornex, :base_url) || "https://api.torn.com/v2"

  @type parameter :: {atom(), term()}
  @type t :: %__MODULE__{
          paths: [atom()],
          parameters: [parameter()]
        }

  defstruct [:paths, :parameters]

  @doc """
  Initialize an empty query against the OpenAPI specification.
  """
  @spec new() :: t()
  def new() do
    %__MODULE__{
      paths: [],
      parameters: []
    }
  end

  @doc """
  Add an OpenAPI path to the query.

  The OpenAPI path must be an implementation of the `Torngen.Client.Path` behavior (originating from the `torngen` library).

  ## Example
  """
  @spec put_path(query :: t(), path :: term()) :: t()
  def put_path(%__MODULE__{paths: paths} = query, path) when is_atom(path) do
    %__MODULE__{query | paths: [path | paths]}
  end

  @doc """
  Add an OpenAPI parameter to the query.

  The parameter will be inserted as either a path or query parameter depending on the OpenAPI specifications for the paths included. The `parameter_value` must be an implementation of the `String.Chars` protocol.

  ## Example
  """
  @spec put_parameter(query :: t(), parameter_name :: atom(), parameter_value :: term()) :: t()
  def put_parameter(%__MODULE__{parameters: parameters} = query, parameter_name, parameter_value)
      when is_atom(parameter_name) do
    String.Chars.impl_for!(parameter_value)
    %__MODULE__{query | parameters: [{parameter_name, parameter_value} | parameters]}
  end

  @spec path_selections!(query :: t()) :: {String.t(), [String.t()]}
  def path_selections!(%__MODULE__{paths: []} = _query) do
    # TODO: Document this function
    raise "No paths were added to the query"
  end

  def path_selections!(%__MODULE__{} = query) do
    # TODO: Add documentation
    {base_path!(query), selections!(query)}
  end

  @doc """
  Generate a URI against the `Tornex.SpecQuery`.

  ## Example
  """
  @spec uri(query :: t()) :: URI.t()
  def uri(%__MODULE__{parameters: parameters, paths: paths} = query) do
    # TODO: Add more documentation
    {path, selections} = path_selections!(query)

    @host
    |> URI.new!()
    |> URI.append_path("/" <> path <> "/")
    |> append_selections(selections)
    |> insert_url_path_parameters(paths, parameters)
    |> insert_url_query_parameters(paths, parameters)
    |> validate_url!()
    |> validate_required_params!(paths)
  end

  @spec base_path!(query :: t()) :: String.t()
  defp base_path!(%__MODULE__{paths: paths} = _query) do
    bases =
      paths
      |> Enum.map(fn path ->
        {base, _selection} = path.path_selection()
        base
      end)
      |> Enum.uniq()

    case Kernel.length(bases) do
      1 -> Enum.at(bases, 0)
      base_count -> raise "#{base_count} base paths were added to the query. Only one should be added."
    end
  end

  @spec selections!(query :: t()) :: [String.t()]
  defp selections!(%__MODULE__{paths: paths} = _query) do
    paths
    |> Enum.map(fn path ->
      {_base, selection} = path.path_selection()
      selection
    end)
    |> Enum.uniq()
  end

  @spec insert_url_path_parameters(uri :: URI.t(), paths :: [atom()], parameters: [parameter()]) :: URI.t()
  defp insert_url_path_parameters(%URI{} = uri, paths, parameters)
       when is_list(paths) and is_list(parameters) do
    # TODO: Restructure this code
    parameters =
      parameters
      |> Enum.filter(fn {name, value} ->
        Enum.any?(paths, fn path ->
          case path.parameter(name, value) do
            {:path, _name, _value} -> true
            :error -> false
            _ -> false
          end
        end)
      end)

    do_insert_path_parameter(uri, parameters)
  end

  @spec insert_url_query_parameters(uri :: URI.t(), paths :: [atom()], parameters: [parameter()]) :: URI.t()
  defp insert_url_query_parameters(%URI{} = uri, paths, parameters) when is_list(paths) and is_list(parameters) do
    # TODO: Restructure this code
    parameters =
      parameters
      |> Enum.filter(fn {name, value} ->
        Enum.any?(paths, fn path ->
          case path.parameter(name, value) do
            {:query, _name, _value} -> true
            :error -> false
            _ -> false
          end
        end)
      end)

    do_insert_query_parameter(uri, parameters)
  end

  defp do_insert_path_parameter(%URI{} = uri, [{name, value} | remaining_parameters])
       when is_atom(name) do
    parameter_name = "{" <> Atom.to_string(name) <> "}"

    if not String.contains?(uri.path, parameter_name) do
      raise "Invalid path parameter #{name}"
    end

    uri = %URI{
      uri
      | path: String.replace(uri.path, parameter_name, to_string(value))
    }

    do_insert_path_parameter(uri, remaining_parameters)
  end

  defp do_insert_path_parameter(%URI{} = uri, []) do
    uri
  end

  defp do_insert_query_parameter(%URI{} = uri, [{name, value} | remaining_parameters]) when is_atom(name) do
    uri = URI.append_query(uri, "#{name}=#{value}")
    do_insert_query_parameter(uri, remaining_parameters)
  end

  defp do_insert_query_parameter(%URI{} = uri, []) do
    uri
  end

  defp append_selections(%URI{} = uri, selections) when is_list(selections) do
    URI.append_query(uri, "selections=" <> Enum.join(selections, ","))
  end

  defp validate_url!(%URI{} = uri) do
    # Need to make sure the user passed a path parameter if they paths includes one
    uri_string = URI.to_string(uri)

    case Regex.run(~r"\{.*\}", uri_string) do
      nil ->
        uri

      [matched_fragment] when is_binary(matched_fragment) ->
        raise "Invalid fragment \"#{matched_fragment}\" in generated URI: #{uri_string}"

      _ ->
        raise "Unknown fragment matching behavior for generated URI: #{uri_string}"
    end
  end

  defp validate_required_params!(%URI{} = uri, paths) when is_list(paths) do
    do_validate_required_params!(uri, paths)
  end

  defp do_validate_required_params!(%URI{} = uri, [_path | remaining_paths]) do
    # TODO: Validate that each required parameter exists
    # NOTE: This could be done with guards on parameters that check values:
    # required params: is_integer(value)
    # optional params: is_nil(value) or is_integer(value)

    do_validate_required_params!(uri, remaining_paths)
  end

  defp do_validate_required_params!(%URI{} = uri, []) do
    uri
  end
end
