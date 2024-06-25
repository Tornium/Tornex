# Copyright 2024 tiksan
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

defmodule Tornix.Query do
  # TODO: Define required keys
  @type t :: %__MODULE__{
          resource: String.t(),
          resource_id: Integer | String.t(),
          key: String.t(),
          key_owner: Integer,
          selections: List,
          from: Integer,
          to: Integer,
          timestamp: Integer,
          limit: Integer,
          sort: :asc | :desc
        }
  defstruct [
    :resource,
    :resource_id,
    :key,
    :key_owner,
    :selections,
    :from,
    :to,
    :timestamp,
    :limit,
    :sort
  ]
end
