# Troop Server - Docker

Docker image which runs a [Troop](https://github.com/Qirky/Troop) server.

> Troop is a real-time collaborative tool that enables group live coding within the same document across multiple computers. Hypothetically Troop can talk to any interpreter that can take input as a string from the command line but it is already configured to work with live coding languages [FoxDot](https://github.com/Qirky/FoxDot), [TidalCycles](https://tidalcycles.org/), and [SuperCollider](http://supercollider.github.io/).

Based on Alpine and Python 3.

## Tags

`latest` (there is no CICD process, this tag may be updated at any time)

`0.9.6`, `0.9`

## Usage

Given [you already have installed Docker on a machine](https://docs.docker.com/install/):

    docker run -d [-e PASSWORD=<password>] --name troop -p 57890:57890 --restart=always troop

### Environment variables

| Name       | Default | Description                         |
| ---------- | ------- | ----------------------------------- |
| `DEBUG`    |         | Set to anything to enable debug.    |
| `LOG`      |         | Set to anything to log performance. |
| `PASSWORD` | empty   | Password.                           |
| `PORT`     | `57890` | Port to listen to.                  |

They correspond to the CLI arguments of Troop's `run-server.py`. However, as of writing, **debug is not implemented**, and **performance logging is broken**, so you are advised not to use these features.

## Build

As of writing, Troop implementation **does not check protocol versions**. I already experienced bugs in the Troop clients because the performers had installed different versions.

To prevent that, clone this repository, build your own server image, and have your participants use the same commit. If you're running a workshop, it is advisable to distribute the sources from that commit on a USB drive, along with Python installers.

The build process retrieves Troop from its repository. Therefore it should work for future or past versions with minimal changes.

    git clone https://github.com/KoltesDigital/troop-server-docker
    cd troop-server-docker
    docker build [--build-arg COMMIT=<commit>] -t troop .
    docker run -d [-e PASSWORD=<password>] --name troop -p 57890:57890 --restart=always troop

### Build arguments

| Name         | Default                          | Description                                   |
| ------------ | -------------------------------- | --------------------------------------------- |
| `COMMIT`     | `OT` (main branch)               | Commit, branch name, or tag name to checkout. |
| `REPOSITORY` | `https://github.com/Qirky/Troop` | Source repository.                            |
