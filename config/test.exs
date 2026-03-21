import Config

config :tornex,
  local: true,
  test_api_key: System.get_env("TORN_API_KEY")
