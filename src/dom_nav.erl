-module(dom_nav).
-description("nav section element connected to browser session history").
-include("nitro.hrl").
-export([render_element/1]).

render_element(Rec) when Rec#nav.show_if==false -> [];
render_element(#nav{id=Id}=Rec) ->
    Cid = case Id of [] -> nitro:temp_id(); I -> I end,
    Lsn = string:replace(Cid, "-", "",all),

    OnPopstate = nitro:f("ws.send(~s);",[iolist_to_binary(
      [ "enc("
      , "tuple(atom('scene'),"
      , "bin(event.state && event.state.id),"
      , "bin(event.state && event.state.cid),"
      , "bin(event.state && event.state.page),"
      , "bin(''),"
      , "bin(window.location.pathname+window.location.hash)"
      , ")"
      , ")"
      ])]),

    nitro:wire(#bind{target={g,window}, type=popstate, postback=OnPopstate, source=Lsn}),

    nitro:wire(iolist_to_binary(
      [ "function pss(st,url){"
      , "event.preventDefault();"
      , "let s=new Event('popstate');"
      , "s.state = st;"
      , "history.pushState(s.state, '', url);"
      , "let ec = Object.setPrototypeOf(s,event);"
      , "window.dispatchEvent(ec);"
      , "}"
      ])),

    Nav = fun(#scene{id=Id1, state=S, title=T, url=U}) ->
      Lid = case Id1 of [] -> nitro:temp_id(); I1 -> I1 end,
      F = nitro:f("pss(Object.assign({page:~w}, {id: \"~s\", cid: \"~s\"}), \"~s\")", [S,Lid,Cid,U]),

      nitro:wire(#bind{target=Lid, type=click, postback=F}),
      #link{id=Lid, href=U, body=T}
    end,

    Routes = case Rec#nav.body of
      Links when is_list(Links) -> [Nav(L) || L <- Links];
      R -> R
    end,

    wf_tags:emit_tag( <<"nav">>, nitro:render(Routes), [
      {<<"id">>,    Cid},
      {<<"class">>, Rec#nav.class},
      {<<"style">>, Rec#nav.style} | Rec#nav.data_fields
    ]).
