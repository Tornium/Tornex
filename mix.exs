defmodule Tornex.MixProject do
  use Mix.Project

  @version "0.4.0-dev"

  def project do
    [
      name: "Tornex",
      description: "Robust API call planning and execution for Torn City",
      app: :tornex,
      version: @version,
      elixir: "~> 1.16",
      package: package(),
      deps: deps(),
      source_url: "https://github.com/Tornium/tornex",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  def deps do
    [
      {:jason, "~> 1.4"},
      {:horde, "~> 0.9", optional: true},
      {:finch, "~> 0.19", optional: true},
      {:telemetry, "~> 1.3"},
      {:prom_ex, "~> 1.11", optional: true},
      {:plug_cowboy, "~> 2.7", optional: true},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:torngen_elixir_client, ">= 1.0.0", optional: true}
    ]
  end

  def package do
    [
      name: "tornex",
      description: "Robust API call planning and execution for Torn City",
      files: ["lib", "mix.exs", "README.md", "LICENSE.md", "CHANGELOG.md"],
      maintainers: ["tiksan"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/Tornium/tornex"}
    ]
  end

  def docs do
    [
      main: "readme",
      extras: ["README.md", "LICENSE.md", "cluster.md"]
    ]
  end
end
