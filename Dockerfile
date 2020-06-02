#===========
#Build Stage
#===========
FROM bitwalker/alpine-elixir:1.10.3 as build

ENV MIX_ENV=prod \
    LANG=C.UTF-8

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

#Copy the source folder into the Docker image
COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY mix.exs .
COPY mix.lock .

#Install dependencies and build Release
RUN mix deps.get
RUN mix release

COPY entrypoint.sh .
RUN chmod a+rx entrypoint.sh

#Set default entrypoint and command
CMD ["./entrypoint.sh"]