-module(cb_microblog_blogger_controller, [Req]).
-compile(export_all).

before_(_) ->
	auth_helper:require_login(Req).

view('GET', [Name], LoggingInBlogger) ->
	case boss_db:find_first(blogger, [{name, equals, Name}]) of
		undefined -> {redirect, "/"};
		Blogger   -> {ok, [{blogger, Blogger}, {statuses, Blogger:statuses()}, {loggingin, LoggingInBlogger}]}
	end;
view('POST', [Name], LoggingInBlogger) ->
	Status = status:new(id, LoggingInBlogger:id(), Req:post_param("text"), timestamp),
	case Status:save() of
		{ok, _} -> {redirect, "/blogger/"++LoggingInBlogger:name()};
		{error, Why} -> {ok, [{error, Why}]}
	end.

list('GET', [], LoggingInBlogger) ->
	case boss_db:find(blogger, []) of
		{error, Why} -> {redirect, "/"};
		Bloggers     -> {ok, [{bloggers, Bloggers}, {loggedin, LoggingInBlogger}]}
	end.

signout('GET', [], LoggingInBlogger) ->
    {redirect, "/", LoggingInBlogger:discard_cookies()}.