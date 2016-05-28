Example Haskell Project
-----------------------

This is a template project for using a specific version of Haskell via Docker.
This allows you to use different versions of core as if you were using a
virtualenv or similar.

### Layout

Application code goes in `src` and the entry point is the `main` method of `src/Main.hs`.

Dependencies go in `example-docker-project.cabal`. When you change dependencies you must rebuild the image.

There are scripts to build and run the code in the `bin` folder.

### Usage

Just copy this folder and update the `example-docker-project.cabal` file. You
should rename it to better match your project.

To use a specific version of GHC edit the `Dockerfile`. The first line
indicates the version of haskell that will be used. You can review the
[tags list](https://hub.docker.com/_/haskell/tags/) to see what versions are
available. At the time of writing the following versions were available:

 * 7.10.3
 * 7.10.2
 * 7.10.1
 * 7.8.4

### Commands

#### bin/build

This creates the Docker image using the cabal dependencies. The Docker image
contains the current source code so it can be distributed.

#### bin/clean

This deletes the Docker image and any containers that reference it. Use this to
clean up before rebuilding.

#### bin/start

This starts the Docker container. This requires that you build the image first.

#### bin/stop

This stops the Docker container.
