-module(mnesia_web_tests).
-include_lib("eunit/include/eunit.hrl").

mnesia_web_test_() ->
    {setup,
     % Setup Fixture
     fun() -> 
         xxx
     end,
     % Cleanup Fixture
     fun(xxx) ->
         ok
     end,
     % List of tests
     [
       % Example test
       fun func1/0
     ]
    }.

func1() ->
    ?assert(
        is_list(mnesia_web:module_info())
    ).
