defmodule Tornex.HTTP.FinchClient do
  @moduledoc """
  The built-in HTTP client for `Tornex.API.get/1`.

  If you wish to use the built-in client, add [Finch](https://github.com/sneako/finch) to your dependencies. You can 
  create your own adapter for an HTTP client by implementing the behaviours defined in `Tornex.HTTP.Client`.
  """

  @behaviour Tornex.HTTP.Client
  @finch_pool_name Tornex.HTTP.FinchPool

  @impl true
  def child_spec(_opts \\ []) do
    if Code.ensure_loaded?(Finch) do
      [
        name: @finch_pool_name,
        pools: %{
          "https://api.torn.com" => [protocols: [:http2], count: 32, start_pool_metrics?: true]
        }
      ]
      |> Finch.child_spec()
    else
      raise """
        Cannot start Tornex's HTTP client because the Finch HTTP library is not installed and Tornex is set to use
        the default Tornex.HTTP.FinchClient.
      """
    end
  end

  @impl true
  def version() do
    finch_version =
      Application.spec(:finch, :vsn)
      |> to_string()
      |> String.replace(".", "_")

    "Finch #{finch_version}"
  end

  @impl true
  def get(url, headers \\ %{}) when is_binary(url) and is_map(headers) do
    Finch.build(:get, url, headers |> Enum.to_list())
    |> Finch.request!(@finch_pool_name)
    |> parse_response()
  end

  @spec parse_response(response :: Finch.Response.t()) :: Tornex.HTTP.Client.response()
  defp parse_response(%Finch.Response{status: status, headers: headers, body: body}) do
    {:ok, status, headers |> Map.new(), body}
  end
end
