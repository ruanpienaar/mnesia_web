#!/bin/bash
export NODENAME=node
export COOKIE=cookie
export MNESIA_DIR=Mnesia
export RELX_REPLACE_OS_VARS=true
./_build/default/rel/mnesia_web/bin/mnesia_web console