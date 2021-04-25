import Config

config :n2o,
  protocols: [:io_naw | Application.compile_env(:n2o, :protocols, [])]
