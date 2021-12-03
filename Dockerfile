# FROM bitwalker/alpine-elixir:latest

# EXPOSE 4000
# ENV PORT 4000

# ENV MIX_ENV=dev

# COPY . .
# RUN export MIX_ENV=dev && \
#     rm -Rf _build && \
#     mix deps.get && \
#     mix release

# RUN apk add inotify-tools
# CMD [ "mix", "ecto.setup", "mix", "phx.server"]
# # CMD [ "mix", "phx.server" ]
# # CMD [ "/bin/bash", "/start.sh" ]

# # ENTRYPOINT ["bash"]
FROM elixir:latest

# Install debian packages
RUN apt-get update && \
    apt-get install --yes build-essential inotify-tools postgresql-client git && \
    apt-get clean

ADD . .

# Install Phoenix packages
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force hex phx_new 1.5.1

# Install node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs

RUN mix deps.get
RUN npm install --prefix ./assets

EXPOSE 4000

CMD ["/entrypoint.sh"]