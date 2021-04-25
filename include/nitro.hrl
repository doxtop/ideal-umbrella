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
-record(naw,  {?ELEMENT_BASE(dom_naw)}).
-endif.
