import Config

config :n2o,
  protocols: [:io_nav | Application.compile_env(:n2o, :protocols, [])]
