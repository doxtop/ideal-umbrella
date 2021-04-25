nitro components playground

####Section navigation

Notify about browser context session history state pop and push new state on `scene` changes.

```erlang
config :n2o,
  protocols: [:io_nav | Application.compile_env(:n2o, protocols,[])]

event(init) ->
  nitro:update(app, #panel{id=app,body=[]}),
  nitro:update(nav, #nav{id=nav, body=[
      #scene{title= <<"Z">>, state=0, url="/index.html#z"}
    , #scene{title= <<"O">>, state=1, url="/index.html#o"}
  ]});
event(#scene{state= <<"0">>}) -> nitro:update(app, #panel{id=app,body=["Z"]};
event(#scene{state= <<"1">>}) -> nitro:update(app, #panel{id=app,body=["O"]}).
```
