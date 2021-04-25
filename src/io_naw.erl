-module(io_naw).
-description("navigation io").
-include_lib("nitro/include/nitro.hrl").
-include("nitro.hrl").
-export([info/3]).

info(#scene{id=Id, cid=Cid}=M,R,Ctx) ->
    Ls = {qa, iolist_to_binary(["#", Cid, " > .active"])},
    nitro:wire(#jq{target={ps, Ls, "classList"}, method=["toggle"], args=["'active'"]}),
    nitro:wire(#jq{target={ps, Id, "classList"}, method=["add"], args=["'active'"]}),

    {reply, {bert, nitro_n2o:io(M,Ctx)},R,Ctx};
info(M,R,S) -> {unknown,M,R,S}.
