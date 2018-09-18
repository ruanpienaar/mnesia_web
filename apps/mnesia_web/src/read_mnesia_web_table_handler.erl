-module(read_mnesia_web_table_handler).

-export([init/2]).

init(Req0, Opts) ->
    Method = cowboy_req:method(Req0),
    Req = handle_req(Method, Req0),
    {ok, Req, Opts}.

handle_req(<<"GET">>, Req0) ->
    case cowboy_req:binding(key, Req0) of
        undefined ->
            cowboy_req:reply(400, [], <<"Missing key.">>, Req0);
        Key ->
            {atomic, Data} = mnesia_web_table:read(Key),
            % [{mnesia_web_table,<<"a">>,[{<<"tsst">>,true}]}]
            BinData = list_to_binary(io_lib:format("~p", [Data])),
            cowboy_req:reply(200, #{
                <<"content-type">> => <<"text/plain; charset=utf-8">>
            }, BinData, Req0)
    end;
handle_req(_, Req) ->
    %% Method not allowed.
    cowboy_req:reply(405, Req).