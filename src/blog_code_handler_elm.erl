-module(blog_code_handler_elm).
-compile([{parse_transform, lager_transform}]).
-behaviour(cowboy_http_handler).

%% Resource functions
-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

%%%---------------------------------------------------------------------
%%% Resource functions
%%%---------------------------------------------------------------------

init(_, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {ok, Body} = elm_dtl:render(State),
  Headers = [{<<"content-type">>, <<"text/html">>}],
  {ok, Reply} = cowboy_req:reply(200, Headers, Body, Req),
  {ok, Reply, State}.

terminate(_Reason, _Req, _State) ->
  ok.

%% Local variables:
%% mode: erlang
%% erlang-indent-level: 2
%% indent-tabs-mode: nil
%% fill-column: 72
%% coding: latin-1
%% End:
