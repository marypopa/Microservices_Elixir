#!/bin/sh
# Docker entrypoint script.

mix ecto.create
mix ecto.migrate

_build/prod/rel/user/bin/user start