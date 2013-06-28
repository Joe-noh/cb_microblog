-module(blogger, [Id, Name, PassDigest, Salt]).
-compile(export_all).

-has({statuses, many, [{order_by, timestamp}, {descending, true}]}).
