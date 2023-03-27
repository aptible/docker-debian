# ![](https://gravatar.com/avatar/11d3bc4c3163e3d238d558d5c9d98efe?s=64) aptible/debian

Debian base image with custom Aptible patches and Dockerfile building tools.

## Intended Use

This image is used internally by Aptible. Aptible customers should not
use this repo, and instead we recommend the Official Docker Debian image:
https://hub.docker.com/_/debian


## Available Tags

* `latest`: Debian 11 (Bullseye)
* `bullseye`: Debian 11
* `buster`: Debian 10
* `stretch`: Debian 9

## Included Tools/Patches

* `bats`: The [Bats](https://github.com/sstephenson/bats) Bash Automated Testing System

## Tests

Tests are run as part of the `Dockerfile` build. To execute them separately within a container, run:

    bats test


## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2019 [Aptible](https://www.aptible.com), [Frank Macreery](https://github.com/fancyremarker), and contributors.
