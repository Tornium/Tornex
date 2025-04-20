defmodule Torngen.Client.Parameter.ApiTo do
  @moduledoc """
  Timestamp that sets the upper limit for the data returned

  Data returned will be up to and including this time
  """

  @parameter_name :to
  @parameter_required false
  @parameter_deprecated false
  @parameter_in :query
end
