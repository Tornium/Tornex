defmodule Torngen.Client.Parameter.ApiFrom do
  @moduledoc """
  Timestamp that sets the lower limit for the data returned

  Data returned will be after this time
  """

  @parameter_name :from
  @parameter_required false
  @parameter_deprecated false
  @parameter_in :query
end
