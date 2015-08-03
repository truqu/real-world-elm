-module(blog_code_sup).
-behaviour(supervisor).

%% Supervisor callbacks
-export([start_link/0]).
-export([init/1]).

-define(CHILD(Id), { Id, {Id, start_link, []}
                   , permanent, infinity, supervisor, [Id]
                   }
       ).

%%%---------------------------------------------------------------------
%%% Supervisor callbacks
%%%---------------------------------------------------------------------

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  Procs = [],
  {ok, {{one_for_one, 1, 5}, Procs}}.

%% Local variables:
%% mode: erlang
%% erlang-indent-level: 2
%% indent-tabs-mode: nil
%% fill-column: 72
%% coding: latin-1
%% End:
