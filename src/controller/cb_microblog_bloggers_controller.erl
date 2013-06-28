-module(cb_microblog_bloggers_controller, [Req]).
-compile(export_all).

view('GET', [Name]) ->
	case boss_db:find_first(blogger, {[name, Name]}) of
		undefined -> {redirect, [{action, "login"}]};
		Blogger   -> {ok, [{blogger, Blogger}, {statuses, Blogger:statuses()}]}
	end.

signin('GET',  []) -> ok;
signin('POST', []) ->
	ok. % TODO

signup('GET',  []) -> ok;
signup('POST', []) ->
	Name = Req:post_param("bloggername"),
	Pass = Req:post_param("password").%,
%	case boss_db:find_first()