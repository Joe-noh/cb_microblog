-module(blogger, [Id, Name, PassDigest, Salt]).
-compile(export_all).

-has({statuses, many}).%%, [{order_by, timestamp, num_descending}]}).
