FROM hexpm/elixir:1.12.2-erlang-24.0.5-ubuntu-xenial-20210114
# install build dependencies
USER root
RUN apt-get update
RUN apt-get install -y git gcc g++ make curl 
RUN apt-get install -y build-essential
RUN mix local.hex --force && \
  mix local.rebar --force
ENV MIX_ENV=prod
COPY . .
RUN mix deps.get && \
  mix deps.compile
RUN mix compile
RUN mix release
CMD ["_build/prod/rel/example/bin/example", "start"]
