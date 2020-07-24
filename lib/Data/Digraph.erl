%%---------------------------------------------------------------------------
%% |
%% Module      :  Digraph
%% Copyright   :  (c) 2020 EMQ Technologies Co., Ltd.
%% License     :  BSD-style (see the LICENSE file)
%%
%% Maintainer  :  Feng Lee, feng@emqx.io
%%                Zhang Shiwei, zhangsw@emqx.io
%% Stability   :  experimental
%% Portability :  portable
%%
%% The Digraph FFI Module.
%%
%%---------------------------------------------------------------------------
-module('Digraph').

-include("Maybe.hrl").

%% FFI
-export([ new/1
        , addVertex/2
        , edge/2
        , vertex/2
        , getCycle/2
        , getPath/3
        , getShortCycle/2
        , getShortPath/3
        ]).

trans([]) -> [];
trans([X | Xs]) -> [case X of
    { 'Cyclic' } -> digraph:cyclic();
    { 'Acyclic' } -> digraph:acyclic();
    { 'Protected' } -> digraph:protected();
    { 'Private' } -> digraph:private()
end | trans(Xs) ].

new(Type) -> digraph:new(trans(Type)).

addVertex(G, Labal) ->
    digraph:add_vertex(g, digraph:add_vertex(G), Labal).

edge(G, E) -> case digraph:edge(G, E) of
    {E, V1, V2, Labal} -> { 'Just', { V1, V2, Labal } };
    false -> { 'Nothing' }
end.

vertex(G, V) -> case digraph:vertex(G, V) of
    {V, Labal} -> { 'Just', Labal };
    false -> { 'Nothing' }
end.

getCycle(G, V) -> case digraph:get_cycle(G, V) of
    false -> [];
    Else -> Else
end.

getPath(G, V1, V2) -> case digraph:get_path(G, V1, V2) of
    false -> [];
    Else -> Else
end.

getShortCycle(G, V) -> case digraph:get_short_cycle(G, V) of
    false -> [];
    Else -> Else
end.

getShortPath(G, V1, V2) -> case digraph:get_short_path(G, V1, V2) of
    false -> [];
    Else -> Else
end.
