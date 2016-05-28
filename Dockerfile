FROM haskell:7.10

ENV PROJECT_NAME "example-docker-project"

WORKDIR /opt/server

RUN cabal update

# Add just the .cabal file to capture dependencies
COPY ./${PROJECT_NAME}.cabal /opt/server/${PROJECT_NAME}.cabal

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
# (unless the .cabal file changes!)
RUN cabal install --only-dependencies -j4

# Add and Install Application Code
COPY . /opt/server
RUN cabal install

CMD dist/build/${PROJECT_NAME}/${PROJECT_NAME}
