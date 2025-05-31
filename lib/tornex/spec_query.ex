# Copyright 2024-2025 tiksan
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

defmodule Tornex.SpecQuery do
  @moduledoc """
  The query struct containing API request data for API v2 requests.

  The `Tornex.SpecQuery` struct works against the OpenAPI specification for the Torn API v2. `Tornex.SpecQuery` can be used by `Tornex.API.torn_get/1` and `Tornex.Scheduler.Bucket.enqueue/1` to make API calls. The struct stores the required information to perform the API call. Alternatively, to make API calls without the OpenAPI specification use `Tornex.Query` instead and prepend the resource with `v2/` (e.g. `v2/user`).

  ## Preparing Query
  Create an empty query using `new/0`. Use `put_path/2` and `put_parameter` to set up the query.

      iex> query =
      ...>   Tornex.SpecQuery.new(nice: 0)
      ...>   |> Tornex.SpecQuery.put_key("foo")
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Bounties)
      ...>   |> Tornex.SpecQuery.put_parameter(:id, 2383326)

  ## Making Query
  The `SpecQuery` can be executed using `Tornex.API.torn_get/1` and `Tornex.Scheduler.Bucket.enqueue/1` to perform the API calls. Once the API call has been finished, the response can be parsed into schema structs and validated using `parse/2`.

      iex> api_response = Tornex.API.torn_get(query)
      iex> parsed_response = Tornex.SpecQuery.parse(query, api_response)
  """

  @host Application.compile_env(:tornex, :base_url) || "https://api.torn.com/v2"

  @type parameter :: {atom(), term()}
  @type t :: %__MODULE__{
          paths: [atom()],
          parameters: [parameter()],
          key: String.t() | nil,

          # Values required for the scheduler
          key_owner: integer(),
          nice: integer(),
          origin: GenServer.from() | nil
        }

  defstruct [
    :paths,
    :parameters,
    :key,

    # Values required for the scheduler
    :key_owner,
    :nice,
    :origin
  ]

  @doc """
  Initialize an empty query against the OpenAPI specification.

  By default, the niceness of the request will be set to 20 and the key owner will be set to 0. The key owner of 0 is intended to be for requests where the owner of the key is not known (e.g. for determining the owner of the API key).
  """
  @spec new(opts :: Keyword.t()) :: t()
  def new(opts \\ []) do
    %__MODULE__{
      paths: Keyword.get(opts, :paths, []),
      parameters: Keyword.get(opts, :parameters, []),
      key: Keyword.get(opts, :key, nil),
      key_owner: Keyword.get(opts, :key_owner, 0),
      nice: Keyword.get(opts, :nice, 20),
      origin: nil
    }
  end

  @doc """
  Add an API key to the query.
  """
  @spec put_key(query :: t(), api_key :: String.t()) :: t()
  def put_key(%__MODULE__{} = query, api_key) when is_binary(api_key) do
    %__MODULE__{query | key: api_key}
  end

  @doc """
  Add the owner of the API key to the query.
  """
  @spec put_key_owner(query :: t(), key_owner :: pos_integer()) :: t()
  def put_key_owner(%__MODULE__{} = query, key_owner) when is_integer(key_owner) do
    %__MODULE__{query | key_owner: key_owner}
  end

  @doc """
  Add an OpenAPI path to the query.

  The OpenAPI path must be an implementation of the `Torngen.Client.Path` behavior (originating from the `torngen` library). However, multiple base resources can not be combined into one query when adding paths to the query. This includes paths for the same resource type (e.g. user) but differing resource IDs such as `/user/${id}/bounties`.

  ## Examples

      iex> query =
      ...>   Tornex.SpecQuery.new()
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Attacks)
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Bounties)
  """
  @spec put_path(query :: t(), path :: term()) :: t()
  def put_path(%__MODULE__{paths: paths} = query, path) when is_atom(path) do
    %__MODULE__{query | paths: [path | paths]}
  end

  @doc """
  Add an OpenAPI parameter to the query.

  During the execution of the query, the parameter will be inserted as either a path or query parameter depending on the OpenAPI specifications for the paths included in the query. The `parameter_value` must be an implementation of the `String.Chars` protocol. If `parameter_value` is a list and the `parameter_name` is a query parameter, the values of the list will be joined with commas and used as the parameter value.

  ## Examples

      iex> query = 
      ...>   Tornex.SpecQuery.new()
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Personalstats)
      ...>   |> Tornex.SpecQuery.put_parameter(:id, 2383326)
      ...>   |> |> Tornex.SpecQuery.put_parameter(:stat, ["attackswon", "attackslost"])
  """
  @spec put_parameter(query :: t(), parameter_name :: atom(), parameter_value :: term()) :: t()
  def put_parameter(%__MODULE__{parameters: parameters} = query, parameter_name, parameter_value)
      when is_atom(parameter_name) do
    String.Chars.impl_for!(parameter_value)
    %__MODULE__{query | parameters: [{parameter_name, parameter_value} | parameters]}
  end

  @doc """
  Parse a `SpecQuery` to determine the base path and selections.

  Raises `RuntimeError` if the `SpecQuery` does not contain any paths or has conflicting base paths.

  ## Examples
      iex> query = 
      ...>   Tornex.SpecQuery.new()
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Personalstats)
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Bounties)
      ...>   |> Tornex.SpecQuery.put_parameter(:id, 2383326)
      ...>   |> Tornex.SpecQuery.put_parameter(:stats, ["attackswon", "attackslost"])
      iex> Tornex.SpecQuery.path_selections!()
      {"user/{id}/", ["personalstats", "bounties"]}

      iex> query = 
      ...>   Tornex.SpecQuery.new()
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Personalstats)
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Attacks)
      ...>   |> Tornex.SpecQuery.put_parameter(:id, 2383326)
      ...>   |> Tornex.SpecQuery.put_parameter(:stats, ["attackswon", "attackslost"])
      iex> Tornex.SpecQuery.path_selections!()
      ** (RuntimeError) 2 base paths were added to the query **

      iex> query = Tornex.SpecQuery.new()
      iex> Tornex.SpecQuery.path_selections!()
      ** (RuntimeError) No paths were added to the query **
  """
  @spec path_selections!(query :: t()) :: {String.t(), [String.t()]}
  def path_selections!(%__MODULE__{paths: []} = _query) do
    raise "No paths were added to the query"
  end

  def path_selections!(%__MODULE__{} = query) do
    {base_path!(query), selections!(query)}
  end

  @doc """
  Generate and validate a URI to perform the `Tornex.SpecQuery`.

  Raises `RuntimeError` if the `SpecQuery` does not contain all of the necessary path parameters or if a base path and selections cannot be determined by `path_selections!/1`.

  ## Examples
      iex> query = 
      ...>   Tornex.SpecQuery.new()
      ...>   |> Tornex.SpecQuery.put_key("foo")
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Personalstats)
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Bounties)
      ...>   |> Tornex.SpecQuery.put_parameter(:id, 2383326)
      ...>   |> Tornex.SpecQuery.put_parameter(:stat, ["attackswon", "attackslost"])
      iex> Tornex.SpecQuery.uri!(query)
      %URI{
        scheme: "https",
        userinfo: nil,
        host: "api.torn.com",
        port: 443,
        path: "/v2/user/2383326",
        query: "selections=personalstats,bounties&key=foo&stat=attackswon,attackslost",
      }

      iex> query = 
      ...>   Tornex.SpecQuery.new()
      ...>   |> Tornex.SpecQuery.put_key("bar")
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.Faction.Id.Chain)
      ...>   |> Tornex.SpecQuery.put_path(Torngen.Client.Path.Faction.Id.Members)
      iex> Tornex.SpecQuery.uri!(query)
      ** (RuntimeError) Invalid fragment "{id}" in generated URI: https://api.torn.com/v2/faction/{id}/?selections=chain,members&key=bar **
  """
  @spec uri!(query :: t()) :: URI.t()
  def uri!(%__MODULE__{parameters: parameters, paths: paths, key: key} = query) when is_binary(key) do
    {path, selections} = path_selections!(query)

    @host
    |> URI.new!()
    |> URI.append_path("/" <> path <> "/")
    |> append_selections(selections)
    |> URI.append_query("key=#{key}")
    |> insert_url_path_parameters(paths, parameters)
    |> insert_url_query_parameters(paths, parameters)
    |> validate_url!()
    |> validate_required_params!(paths)
  end

  @doc """
  Parse the response of an API call against the query into schema structs.

  ## Examples
  """
  @spec parse(query :: t(), response :: list() | map()) :: %{module() => term()}
  def parse(%__MODULE__{paths: paths} = _query, response)
      when (is_list(response) or is_map(response)) and Kernel.length(paths) > 0 do
    # TODO: Document this function

    paths
    |> Enum.map(fn path when is_atom(path) -> {path, path.parse(response)} end)
    |> Map.new()
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
      base_count -> raise "#{base_count} base paths were added to the query"
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

  defp do_insert_query_parameter(%URI{} = uri, [{name, value} | remaining_parameters])
       when is_atom(name) and is_list(value) do
    uri = URI.append_query(uri, "#{name}=#{Enum.join(value, ",")}")
    do_insert_query_parameter(uri, remaining_parameters)
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
