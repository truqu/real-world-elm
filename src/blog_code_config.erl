-module(blog_code_config).

%%% API
-export([value/1]).

%%%---------------------------------------------------------------------
%%% API
%%%---------------------------------------------------------------------

value(Name) ->
    {ok, V} = application:get_env(blog_code, Name),
    V.

%%% Local variables:
%%% mode: erlang
%%% erlang-indent-level: 2
%%% indent-tabs-mode: nil
%%% fill-column: 72
%%% coding: latin-1
%%% End:
