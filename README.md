# AutoDump Docker Image

[![GitHub Actions][github-image]][github-url]

This repository hosts the automation to build the docker image used by the AutoDump automation.

See [AutoDump](https://github.com/truemark/autodump)

The image generated has the following PostgreSQL clients installed:

 - /usr/lib/postgresql/10/bin/psql
 - /usr/lib/postgresql/15/bin/psql
 - /usr/lib/postgresql/11/bin/psql
 - /usr/lib/postgresql/12/bin/psql
 - /usr/lib/postgresql/14/bin/psql
 - /usr/lib/postgresql/16/bin/psql
 - /usr/lib/postgresql/13/bin/psql

The latest version is what is linked to /usr/local/bin/psql

## Reference

[github-url]: https://github.com/truemark/autodump-docker/actions
[github-image]: https://github.com/truemark/autodump-docker/workflows/release/badge.svg
