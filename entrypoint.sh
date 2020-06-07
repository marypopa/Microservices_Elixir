#!/bin/sh
# Docker entrypoint script.

source wait.sh

mix ecto.create
mix ecto.migrate

_build/prod/rel/user/bin/user start