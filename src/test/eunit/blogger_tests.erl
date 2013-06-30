-module(blogger_tests).
-include_lib("eunit/include/eunit.hrl").

status_order_test() ->
	B = blogger:new(id, "joe", "pass", "salt"),
	{ok, Blogger} = B:save(),

	Status1 = status:new(id, Blogger:id(),   "hello", timestamp),
	Status2 = status:new(id, Blogger:id(),   "world", timestamp),
	Status3 = status:new(id, Blogger:id(), "goodbye", timestamp),

	Status1:save(), Status2:save(), Status3:save(),

	Texts = [Text || {status, _, _, Text, _} <- Blogger:statuses()],
	?assertEqual(["goodbye", "world", "hello"], Texts).

name_chars_test() ->
    B1 = blogger:new(id, "Arm_Strong", "pass", "salt"), %% ok
    B2 = blogger:new(id, "arm_str0ng", "pass", "salt"), %% ok
    B3 = blogger:new(id, "arm-strong", "pass", "salt"), %% hyphen
    B4 = blogger:new(id, "          ", "pass", "salt"), %% space

    {ok,    _} = B1:save(),
    {ok,    _} = B2:save(),
    {error, _} = B3:save(),
    {error, _} = B4:save().