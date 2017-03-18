# osixia/backup

[![Docker Pulls](https://img.shields.io/docker/pulls/osixia/backup.svg)][hub]
[![Docker Stars](https://img.shields.io/docker/stars/osixia/backup.svg)][hub]
[![](https://images.microbadger.com/badges/image/osixia/backup.svg)](http://microbadger.com/images/osixia/backup "Get your own image badge on microbadger.com")

[hub]: https://hub.docker.com/r/osixia/backup/

Latest release: 0.1.2 - [Changelog](CHANGELOG.md) | [Docker Hub](https://hub.docker.com/r/osixia/backup/) 

**A docker image to periodically backup directories.**

- [Quick start](#quick-start)
- [Beginner Guide](#beginner-guide)
	- [Backup directory and data persistence](#backup-directory-and-data-persistence)
	- [Debug](#debug)
- [Environment Variables](#environment-variables)
	- [Set your own environment variables](#set-your-own-environment-variables)
		- [Use command line argument](#use-command-line-argument)
		- [Link environment file](#link-environment-file)
		- [Make your own image or extend this image](#make-your-own-image-or-extend-this-image)
- [Advanced User Guide](#advanced-user-guide)
	- [Extend osixia/backup:0.1.2 image](#extend-osixiabackup012-image)
	- [Make your own backup image](#make-your-own-backup-image)
	- [Tests](#tests)
	- [Under the hood: osixia/light-baseimage](#under-the-hood-osixialight-baseimage)
- [Changelog](#changelog)

## Quick start

    # Run Backup Manager image
    docker run --volume /host/data:/data/input --volume /host/backup:/data/backup --detach osixia/backup:0.1.2

## Beginner Guide

### Backup directory and data persistence

Backups are created by default in the directory `/data/backup` that has been declared as a volume, so your backup files are saved outside the container in a data volume.

For more information about docker data volume, please refer to :

> [https://docs.docker.com/userguide/dockervolumes/](https://docs.docker.com/userguide/dockervolumes/)

### Debug

The container default log level is **info**.
Available levels are: `none`, `error`, `warning`, `info`, `debug` and `trace`.

Example command to run the container in `debug` mode:

	docker run --detach osixia/backup:0.1.2 --loglevel debug

See all command line options:

	docker run osixia/backup:0.1.2 --help

## Environment Variables

Environment variables defaults are set in **image/environment/default.yaml**

See how to [set your own environment variables](#set-your-own-environment-variables)


- **BACKUP_INPUT**: Directory to backup. Defaults to `/data/input`.


- **BACKUP_OUTPUT**: Directorie to save backups in. Defaults to `/data/backup`.


- **BACKUP_CRON_EXP**: Cron expression to schedule backup execution. Defaults to `0 4 * * *`. Every days at 4am.

- **BACKUP_TTL**: Backup TTL in days. Defaults to `15`.

### Set your own environment variables

#### Use command line argument
Environment variables can be set by adding the --env argument in the command line, for example:

	docker run --env BACKUP_CRON_EXP="0 1 * * *" \
	--detach osixia/backup:0.1.2

#### Link environment file

For example if your environment file is in :  /data/backup/environment/my-env.yaml

	docker run --volume /data/backup/environment/my-env.yaml:/container/environment/01-custom/env.yaml \
	--detach osixia/backup:0.1.2

Take care to link your environment file to `/container/environment/XX-somedir` (with XX < 99 so they will be processed before default environment files) and not  directly to `/container/environment` because this directory contains predefined baseimage environment files to fix container environment (INITRD, LANG, LANGUAGE and LC_CTYPE).

#### Make your own image or extend this image

This is the best solution if you have a private registry. Please refer to the [Advanced User Guide](#advanced-user-guide) just below.

## Advanced User Guide

### Extend osixia/backup:0.1.2 image

If you need to add your custom TLS certificate, bootstrap config or environment files the easiest way is to extends this image.

Dockerfile example:

    FROM osixia/backup:0.1.2
    MAINTAINER Your Name <your@name.com>

    ADD environment /container/environment/01-custom


### Make your own backup image

Clone this project :

	git clone https://github.com/osixia/docker-backup
	cd docker-backup

Adapt Makefile, set your image NAME and VERSION, for example :

	NAME = osixia/backup
	VERSION = 0.1.2

	becomes :
	NAME = billy-the-king/backup
	VERSION = 0.1.2

Add your custom keys, environment files, config ...

Build your image :

	make build

Run your image :

	docker run -d billy-the-king/backup:0.1.2

### Tests

We use **Bats** (Bash Automated Testing System) to test this image:

> [https://github.com/sstephenson/bats](https://github.com/sstephenson/bats)

Install Bats, and in this project directory run :

	make test

### Under the hood: osixia/light-baseimage

This image is based on osixia/light-baseimage.
More info: https://github.com/osixia/docker-light-baseimage

## Changelog

Please refer to: [CHANGELOG.md](CHANGELOG.md)
