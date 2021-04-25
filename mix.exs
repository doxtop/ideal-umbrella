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

  def application, do: [extra_applications: [], applications: [:nitro]]
  defp deps, do: [ {:nitro, "~> 6.4"} ]
end
