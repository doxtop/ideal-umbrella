defmodule Idu.MixProject do
  use Mix.Project

  def project, do: [
      app: :idu,
      description: "Nitro Elements",
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
  ]

  def application, do: [extra_applications: [], applications: []]
  defp deps, do: [
    # transient crypto? will start asn1,ssl,inets,hex etc.
    {:n2o, "~> 8.12",  runtime: false, app: false},
    {:nitro, "~> 7.2", runtime: false, app: false}
  ]
end
