defmodule Tornex.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :tornex,
      version: @version,
      elixir: "~> 1.16",
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :hackney]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  def deps do
    [
      {:tesla, "~> 1.14"},
      {:jason, "~> 1.4"},
      {:hackney, "~> 1.23"},
      {:telemetry, "~> 1.3"},
      {:prom_ex, "~> 1.11", optional: true},
      {:plug_cowboy, "~> 2.7", optional: true}
    ]
  end

  def package do
    [
      description: "Simple Elixir Wrapper for the Torn API",
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["tiksan"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/Tornium/tornex"}
    ]
  end
end
