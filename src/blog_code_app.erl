-module(blog_code_app).
-behaviour(application).

%% API
-export([start/2]).
-export([stop/1]).

%% Macros
-define(
   STATIC_DIR(Name),
   { "/" ++ Name ++ "/[...]"
   , cowboy_static
   , {priv_dir, blog_code, Name}
   }
  ).

-define(
   ROUTES,
   [ ?STATIC_DIR("js")
   , {'_', blog_code_handler_elm, []}
   ]
  ).

%%%---------------------------------------------------------------------
%%% API
%%%---------------------------------------------------------------------

start(_Type, _Args) ->
  %% Initialize cowboy
  Dispatch = cowboy_router:compile([{'_', ?ROUTES}]),
  {ok, _} = cowboy:start_http(
              my_http_listener,
              100,
              [{port, blog_code_config:value(port)}],
              [{env, [{dispatch, Dispatch}]}]
             ),
  blog_code_sup:start_link().

stop(_State) ->
  ok.

%% Local variables:
%% mode: erlang
%% erlang-indent-level: 2
%% indent-tabs-mode: nil
%% fill-column: 72
%% coding: latin-1
%% End:
