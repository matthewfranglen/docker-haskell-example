FROM haskell:7.10

ENV PROJECT_NAME "example-docker-project"

WORKDIR /opt/server

RUN cabal update

# Add just the .cabal file to capture dependencies
COPY ./${PROJECT_NAME}.cabal /opt/server/${PROJECT_NAME}.cabal

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
# (unless the .cabal file changes!)
RUN stack init
RUN stack setup

# Add and Install Application Code
COPY . /opt/server

RUN stack setup
RUN stack build

CMD stack exec ${PROJECT_NAME}
