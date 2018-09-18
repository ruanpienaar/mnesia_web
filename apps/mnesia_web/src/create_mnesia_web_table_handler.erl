-module(create_mnesia_web_table_handler).

-export([init/2]).

init(Req0, Opts) ->
    Method = cowboy_req:method(Req0),
    HasBody = cowboy_req:has_body(Req0),
    Req = handle_req(Method, HasBody, Req0),
    {ok, Req, Opts}.

handle_req(<<"POST">>, true, Req0) ->
    case cowboy_req:binding(key, Req0) of
        undefined ->
            cowboy_req:reply(400, [], <<"Missing key.">>, Req0);
        Key ->
            {ok, PostVals, Req} = cowboy_req:read_urlencoded_body(Req0),
            io:format("~p~n", [PostVals]),
            {atomic, ok} = mnesia_web_table:create(Key, PostVals),
            cowboy_req:reply(200, #{
                <<"content-type">> => <<"text/plain; charset=utf-8">>
            }, <<"">>, Req)
    end;
handle_req(<<"POST">>, false, Req) ->
    cowboy_req:reply(400, [], <<"Missing body.">>, Req);
handle_req(_, _, Req) ->
    %% Method not allowed.
    cowboy_req:reply(405, Req).

% echo(undefined, Req) ->
%     cowboy_req:reply(400, [], <<"Missing echo parameter.">>, Req);
% echo(Echo, Req) ->
%     cowboy_req:reply(200, #{
%         <<"content-type">> => <<"text/plain; charset=utf-8">>
%     }, Echo, Req).