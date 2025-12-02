defmodule Tornex.Spec do
  @moduledoc """
  Utilities for handling the OpenAPI specification and its generated client.
  """

  @typedoc """
  The parsed module documentation for an OpenAPI path in the following ordered list of sections:

  - Path summary
  - Path description
  - Path parameters
  - Potential path response modules (under `Torngen.Client.Schema`)
  """
  @type parsed_path_module_docs :: [String.t()]

  @type api_key_type :: :public | :minimal | :limited | :full

  @doc """
  Get and split the `@moduledoc` of a generated path module.

  The response should be of form `[summary, description, parameters, response_modules]` may change as [`torngen`](https://hex.pm/packages/torngen) changes.

  ## Example
    iex> path_module_docs(Torngen.Client.Path.Faction.Attacks)
    [
      "Get your faction's detailed attacks.",
      "Requires limited access key with faction API access permissions.",
      "## Parmeters\\n- filters: It's possible to use this query parameter to only get incoming or outgoing attacks / revives\\n- limit: N/A\\n- sort: Sorted by the greatest timestamps\\n- to: Timestamp that sets the upper limit for the data returned\\n- from: Timestamp that sets the lower limit for the data returned\\n- timestamp: Timestamp to bypass cache\\n- comment: Comment for your tool/service/bot/website to be visible in the logs.\\n- key: API key (Limited)",
      "## Response Module(s)\\n- FactionAttacksResponse\\n"
    ]
  """
  @spec path_module_docs(path_module :: module()) :: parsed_path_module_docs()
  def path_module_docs(path_module) when is_atom(path_module) do
    {:docs_v1, _, :elixir, _, %{"en" => module_doc}, _, _} = Code.fetch_docs(path_module)

    String.split(module_doc, "\n\n")
  end

  @doc """
  Determine if a generated path module provides public information.

  For a path to be public:
    - There must not be differing responses depending on the invoker.
    - The minimum API key type must be public.
    - The queries must not require an additional in-game permission such as faction API access. This can be ensuring
    the API key is a public key.

  """
  @spec path_module_public?(path_module :: module()) :: boolean()
  def path_module_public?(path_module) when is_atom(path_module) do
    # TODO: Test this
    
    # We can determine if there are different responses depending on the invoker (determining if the caller "owns"
    # the resource + resource ID) by checking:
    #  - The description of the path is of form: "Requires ... key. ... when requesting ...".
    #  - The API key parameter must be `ApiKeyPublic`.
    #  - The summary of the path contains "your" or "you" as that will differ between people (a path with an
    #    `{id}` path parameter should be used instead).

    not has_extended_response?(path_module) and api_key_type(path_module) == :public and not contains_you?(path_module)
  end

  @doc """
  Get minimum API key type for the path module.

  ## Example
    iex> api_key_type(Torngen.Client.Path.Faction.Attacks)
    :limited
  """
  @spec api_key_type(path_module :: module()) :: api_key_type()
  def api_key_type(path_module) when is_atom(path_module) do
    [
      _path_summary,
      _path_description,
      path_parameters,
      _path_response_modules
    ] = path_module_docs(path_module)

    path_parameters
    |> String.split("\n- ")
    |> Enum.find(fn parameter -> String.starts_with?(parameter, "key: API key") end)
    |> String.split(["(", ")"])
    |> Enum.at(1)
    |> String.downcase()
    |> String.to_existing_atom()

    # TODO: Ensure that the response atom is one of the API key types
  end

  @doc """
  Determine if there is the path module can return a different response.

  Typically, the extended/different response occurs when the owner of the resource is making the call on a selection
  that only requires a public API key.

  ## Examples
    iex> has_extended_response?(Torngen.Client.Path.Faction.Attacks)
    false
    
    iex> has_extended_response?(Torngen.Client.Path.User.Battlestats)
    false

    iex> has_extended_response?(Torngen.Client.Path.User.Icons)
    true
  """
  @spec has_extended_response?(path_module :: module()) :: boolean()
  def has_extended_response?(path_module) when is_atom(path_module) do
    [
      _path_summary,
      path_description,
      _path_parameters,
      _path_response_modules
    ] = path_module_docs(path_module)

    # A path has an extended response when the description is of form:
    #  "Requires ... access key. ... when requesting ..."
    # This indicates that there may be additional data included in the response to the query
    # when the resource owner makes the query. This can potentially leak private information,
    # so we should avoid combining queries that have an extended response with queries made 
    # by the key owner.
    Regex.match?(
      ~r/requires (public|minimal|limited|full) access key\. .*when requesting .*(public|minimal|limited|full).*\./,
      String.downcase(path_description)
    )
  end

  @spec contains_you?(path_module :: module()) :: boolean()
  defp contains_you?(path_module) when is_atom(path_module) do
    # This handles both "you" and "your"

    [
      path_summary,
      _path_description,
      _path_parameters,
      _path_response_modules
    ] = path_module_docs(path_module)

    path_summary
    |> String.downcase()
    |> String.contains?("you")
  end
end
