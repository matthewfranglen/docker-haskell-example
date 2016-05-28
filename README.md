Maul Slack Bot
--------------

This is the slack bot for maul.

### Layout

Application code goes in `src` and the entry point is the `main` method of `src/Main.hs`.

Dependencies go in `example-docker-project.cabal`. When you change dependencies you must rebuild the image.

There are scripts to build and run the code in the `bin` folder.

### Usage

```bash
➜ bin/clean
➜ bin/build
➜ bin/start
➜ bin/logs
...
➜ bin/stop
```

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

#### bin/logs

This shows the logs for the Docker container. This will work after the
container has exited but removing the container will remove the logs.
