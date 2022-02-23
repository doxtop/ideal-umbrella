% proto

%% browsing context session history

-record(scene,{ id    = [] :: [] | binary()            % link id
              , cid   = [] :: [] | binary()            % control id
              , state = [] :: [] | term()              % state
              , title = [] :: [] | binary() | string() % title
              , url   = [] :: [] | binary() | string() % url
              }).

% elements

% to export record in elixir we need a macros to be in scope for epp code preprocessor
% not sure yet how to pass complex definition for ?ELEMENT_BASE macros as {macros, PredefMacros} opts in parse_file/3
% probably some attribute :record can be generated with help of erl_parse but i've no workin example yet
% so just include whole lib here and to avoid manual macro settings
%
% > :erl_parse.abstract({})
% > {:tuple, 0, []}
% > m = {:ELEMENT_BASE, ???}
% > {:ok, e1} = :epp.parse_file('deps/idu/include/test.hrl', [{:macros, [m]}])
%
%-ifdef(ELEMENT_BASE).
-include_lib("nitro/include/nitro.hrl").
-record(naw,  {?ELEMENT_BASE(dom_naw)}).
%-endif.
