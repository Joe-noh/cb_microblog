-module(cb_microblog_blogger_controller, [Req]).
-compile(export_all).

before_(_) ->
	auth_helper:require_login(Req).

view('GET', [Name], LoggedInBlogger) ->
	case boss_db:find_first(blogger, [{name, equals, Name}]) of
		undefined -> {redirect, "/"};
		Blogger   -> {ok, [{blogger, Blogger}, {statuses, Blogger:statuses()}, {loggedin, LoggedInBlogger}]}
	end.

list('GET', [], LoggedInBlogger) ->
	case boss_db:find(blogger, []) of
		{error, Why} -> {redirect, "/"};
		Bloggers     -> {ok, [{bloggers, Bloggers}, {loggedin, LoggedInBlogger}]}
	end.
