-ifdef(NITRO_HRL).
-include_lib("nitro/include/nitro.hrl").
-endif.

% proto

%% browsing context session history

-record(scene,{ id    = [] :: [] | binary()            % link id
              , cid   = [] :: [] | binary()            % control id
              , state = [] :: [] | term()              % state
              , title = [] :: [] | binary() | string() % title
              , url   = [] :: [] | binary() | string() % url
              }).

% elements

-ifdef(ELEMENT_BASE).

-record(nav,  {?ELEMENT_BASE(dom_nav)}).

-else.
-record(nav,  {id,show_if,body,class,style,data_fields}).
-record(link, {id,body,href}).
-endif.
-ifndef(ACTION_BASE).
-record(jq,   {target, property, method, args, right, format}).
-record(bind, {source, target, type=click, postback}).
-endif.
