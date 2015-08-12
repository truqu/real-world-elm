-module(blog_code_handler_api_artists).
-compile([{parse_transform, lager_transform}]).

%% Resource functions
-export([init/3]).
-export([content_types_provided/2]).
-export([allowed_methods/2]).
-export([to_json/2]).

%%%---------------------------------------------------------------------
%%% Resource functions
%%%---------------------------------------------------------------------

init(_Transport, _Req, []) ->
  {upgrade, protocol, cowboy_rest}.

allowed_methods(Req, _) ->
  {[<<"HEAD">>, <<"GET">>, <<"POST">>], Req, #{}}.

content_types_provided(Req, State) ->
  {[{{<<"application">>, <<"json">>, '*'}, to_json}], Req, State}.

to_json(Req, State) ->
  Json = jiffy:encode(
           [ #{id => 1, name => <<"Juan Atkins">>}
           , #{id => 2, name => <<"Larry Heard">>}
           , #{id => 3, name => <<"Marcos Valle">>}
           , #{id => 4, name => <<"Arthur Russell">>}
           , #{id => 5, name => <<"Charles Mingus">>}
           , #{id => 6, name => <<"Nils Frahm">>}
           , #{id => 7, name => <<"Sun Kil Moon">>}
           , #{id => 8, name => <<"Sleaford Mods">>}
           ]
          ),
  {Json, Req, State}.

%% Local variables:
%% mode: erlang
%% erlang-indent-level: 2
%% indent-tabs-mode: nil
%% fill-column: 72
%% coding: latin-1
%% End:
