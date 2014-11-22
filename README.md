# ![](https://gravatar.com/avatar/11d3bc4c3163e3d238d558d5c9d98efe?s=64) aptible/debian

[![Docker Repository on Quay.io](https://quay.io/repository/aptible/debian/status)](https://quay.io/repository/aptible/debian)

Debian base image with custom Aptible patches and Dockerfile building tools.

## Installation and Usage

    docker pull quay.io/aptible/debian
    docker run -i -t quay.io/aptible/debian

## Available Tags

* `latest`: Debian 7 (Wheezy)
* `wheezy`: Debian 7 (Wheezy)

## Included Tools/Patches

* `bats`: The [Bats](https://github.com/sstephenson/bats) Bash Automated Testing System
* `git`: Git Version Control System.

## Tests

Tests are run as part of the `Dockerfile` build. To execute them separately within a container, run:

    bats test

## Deployment

To push the Docker image to Quay, run the following command:

    make release

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2014 [Aptible](https://www.aptible.com), [Frank Macreery](https://github.com/fancyremarker), and contributors.
