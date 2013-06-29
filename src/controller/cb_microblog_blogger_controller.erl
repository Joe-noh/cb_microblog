-module(cb_microblog_blogger_controller, [Req]).
-compile(export_all).

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

signin('GET',  []) -> ok;
signin('POST', []) ->
	ok. % TODO

signup('GET',  []) -> ok;
signup('POST', []) ->
	Name = Req:post_param("bloggername"),
	Pass = Req:post_param("password").%,
%	case boss_db:find_first()