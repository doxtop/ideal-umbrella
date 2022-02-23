-module(dom_naw).
-description("nav section element connected to browser session history").
-include_lib("nitro/include/nitro.hrl").
-include("nitro.hrl").
-export([render_element/1]).

render_element(Rec) when Rec#naw.show_if==false -> [];
render_element(#naw{id=Id}=Rec) ->
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

    % notes from crm:
    % - links should get individual class from scene
    % - naw should have default scene
    % - naw should have tab sorting attribute, usort maybe for scenes to save time on client
    % - order choice: id, title, ?
    % - flex items can have order in style, so style for inner links shoud also be provded
    % - page is formatted in terms of terms, so lists should be decoded by :unicode module

    % ts will fail on integer states, we used term before
    %
    Nav = fun(#scene{id=Id1, state=S, title=T, url=U}) ->
      Lid = case Id1 of [] -> nitro:temp_id(); I1 -> I1 end,
      F = nitro:f("pss(Object.assign({page:\"~ts\"}, {id: \"~s\", cid: \"~s\"}), \"~s\")", [S,Lid,Cid,U]),

      nitro:wire(#bind{target=Lid, type=click, postback=F}),
      #link{id=Lid, href=U, body=T}
    end,

    Routes = case Rec#naw.body of
      [] -> [];
      Links when is_list(Links) -> 
        Lxs = [Nav(L) || L <- Links],
        nitro:wire(#bind{target=Cid
          , type=reset
          , postback=nitro:f("qi('~s').dispatchEvent(new Event('click'));", [(hd(Lxs))#link.id])
          }),
        Lxs;
      R -> R
    end,

    nitro:wire(#jq{target=Cid, method=["dispatchEvent"] , args= ["new CustomEvent('reset', {detail: {}})"]}),

    wf_tags:emit_tag( <<"nav">>, nitro:render(Routes), [
      {<<"id">>,    Cid},
      {<<"class">>, Rec#naw.class},
      {<<"style">>, Rec#naw.style} | Rec#naw.data_fields
    ]).
