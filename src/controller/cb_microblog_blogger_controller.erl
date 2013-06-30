-module(cb_microblog_blogger_controller, [Req]).
-compile(export_all).

before_(_) ->
	auth_helper:require_login(Req).

view('GET', [Name]) ->
	case boss_db:find_first(blogger, [{name, equals, Name}]) of
		undefined -> {redirect, "/"};
		Blogger   -> {ok, [{blogger, Blogger}, {statuses, Blogger:statuses()}]}
	end.

list('GET', []) ->
	case boss_db:find(blogger, []) of
		{error, Why} -> {redirect, "/"};
		Bloggers     -> {ok, [{bloggers, Bloggers}]}
	end.
