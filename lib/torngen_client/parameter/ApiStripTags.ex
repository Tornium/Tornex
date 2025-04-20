defmodule Torngen.Client.Parameter.ApiStripTags do
  @moduledoc """
  Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').

  No further description.
  """

  @parameter_name :striptags
  @parameter_required false
  @parameter_deprecated false
  @parameter_in :query
end
