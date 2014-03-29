scotty.js
=========
scotty is a project toolkit for the [Phaser](http://phaser.io) HTML5 game framework.
It runs as a standalone desktop application, and allows you to

- Download Phaser versions
- Download and run Phaser examples
- Manager your Game Projects

For more information, see the [scotty page.](http://tchannel.github.io/scottyjs)


## Note

scotty is still in an early/experimental state, so be warned:

- there will probably be bugs
- scotty isn't entirely complete. There are new features planned!




## Downloading

Grab the latest download for your operating system [here.](http://github.com/tchannel/scottyjs/releases/latest)


## Building scotty yourself

scotty requires [nodejs](http://nodejs.org/) and [grunt](http://gruntjs.com).

First, clone the repository

    git clone https://github.com/tchannel/scottyjs.git

Install dependencies

    npm install

scotty is written in coffeescript. If you're going to be modifying scotty, you can either
build the app once using `grunt coffee` or you can watch for changes and recompile automatically by running `grunt watch`.

then, to run scotty

    npm start


## Bugs

If you encounter bugs, please file an issue on [scotty github](https://github.com/tchannel/scottyjs/issues/new). If possible include error text and a screenshot.


## Todo

- Rework scotty-gui to use [AngularJS](http://angularjs.org)
- Allow creating projects from templates
- Project deployment tools
- Option for downloading only phaser .js and .min.js rather than the entire phaser repo
- Clean up grunt tasks and config
- Investigate switching to using straight coffeescript includes instead of compiling
