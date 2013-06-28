-module(blogger_tests).
%-include("/opt/local/lib/erlang/lib/eunit-2.2.4/include/eunit.hrl").
-include_lib("eunit/include/eunit.hrl").

suite_test_() ->
    Suite = {foreach, local, fun setup/0, tests()},
    Suite.

tests() ->
	[{"Statuses must be sorted from newest to oldest.", ?_test(status_order_test())}].

status_order_test() ->
	B = blogger:new(id, "joe", "pass", "salt"),
	{ok, Blogger} = B:save(),

	Status1 = status:new(id, Blogger:id(),   "hello", timestamp),
	Status2 = status:new(id, Blogger:id(),   "world", timestamp),
	Status3 = status:new(id, Blogger:id(), "goodbye", timestamp),

	Status1:save(), Status2:save(), Status3:save(),

	Texts = [Text || {status, _, _, Text, _} <- Blogger:statuses()],
	?assertEqual(["goodbye", "world", "hello"], Texts).

%some_test() ->
%	?assert("arm" =:= "strong").

setup() -> ok.
%	B = blogger:new(id, "joe", "pass", "salt"),
%	{ok, Blogger} = B:save().