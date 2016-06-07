Maul Slack Bot
--------------

This is the slack bot for maul.

### Layout

Application code goes in `src` and the entry point is the `main` method of `src/Main.hs`.

Dependencies go in `maul-docker-slack-bot.cabal`. When you change dependencies you must rebuild the image.

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

This downloads the stack dependencies and builds the code.

#### bin/clean

This removes any downloaded dependencies or compiled code.

#### bin/start

This starts the slack bot.

#### bin/stop

This stops the slack bot. It's just really aggressive so don't use it unless you have to.
