# Gorse Helm Chart

[Gorse](https://gorse.io) An open-source recommender system service written in Go.

## TL;DR;

```bash
$ helm install gorse
```

## Introduction

This chart bootstraps a Gorse deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

**Note**: This chart doesn't support horizontal scaling yet.

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm upgrade --name my-release --install gorse
```

**Note**: Gorse requires a properly configured database in order to initialize. See the `values.yaml` file for the configuration values that need to be set. Also, if preferred you can set `postgresql.enabled` to `true` and Helm will deploy the PostgreSQL chart listed in the `requirements.yaml` file, and Gorse will be able to initialize properly using the default values.

**Note**: Gorse requires a properly configured cahce in order to initialize. See the `values.yaml` file for the configuration values that need to be set. Also, if preferred you can set `redis.enabled` to `true` and Helm will deploy the Redis chart listed in the `requirements.yaml` file, and Gorse will be able to initialize properly using the default values.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm unistall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Prisma HA chart and their default values.

| Parameter                        | Description                                  | Default                                                 |
| -------------------------------- | -------------------------------------------- | ------------------------------------------------------- |
| `serviceAccount.create`          | If true, create a service account for Prisma | `true`                                                  |
| `serviceAccount.name`            | Name of the service account to create or use | `{{ prisma.fullname }}`                                 |
| `image.repository`               | Prisma image repository                      | `welevelacademy/prisma-prod`                            |
| `image.tag`                      | Prisma image tag                             | `1.29.1-heroku`                                         |
| `image.pullPolicy`               | Image pull policy                            | `IfNotPresent`                                          |
| `database.connector`             | Database connector                           | `postgres`                                              |
| `database.host`                  | Host for the database endpoint               | `""`                                                    |
| `database.port`                  | Port for the database endpoint               | `""`                                                    |
| `database.name`                  | Database name for Prisma objects             | `prisma`                                                |
| `database.schema`                | Database schema for Prisma objects           | `dafault`                                               |
| `database.user`                  | Database user                                | `prisma`                                                |
| `database.password`              | Database password                            | `""`                                                    |
| `database.migrations`            | Enable database migrations                   | `true`                                                  |
| `database.ssl`                   | Enable SSL for DB connections                | `false`                                                 |
| `database.connectionLimit`       | The maximum number of database connections   | `2`                                                     |
| `api.enabled`                    | Enable Prisma Management API                 | `false`                                                 |
| `api.auth`                       | Enable Prisma Management API authentication  | `false`                                                 |
| `api.secret`                     | Secret to use for authentication             | `nil`                                                   |
| `messaging.enabled`              | Enable Messaging using RabbitMQ API          | `false`                                                 |
| `messaging.rabbitUri`            | RabbitMQ URI                                 | `false`                                                 |
| `api.secret`                     | Secret to use for authentication             | `nil`                                                   |
| `service.type`                   | Type of Service                              | `ClusterIP`                                             |
| `service.port`                   | Service TCP port                             | `4466`                                                  |
| `ingress.enabled`                | Enables Ingress                              | `false`                                                 |
| `ingress.annotations`            | Ingress annotations                          | `{}`                                                    |
| `ingress.path`                   | Ingress path                                 | `/`                                                     |
| `ingress.hosts`                  | Ingress accepted hostnames                   | `[]`                                                    |
| `ingress.tls`                    | Ingress TLS configuration                    | `[]`                                                    |
| `resources`                      | CPU/Memory resource requests/limits          | `{}`                                                    |
| `nodeSelector`                   | Node labels for pod assignment               | `{}`                                                    |
| `affinity`                       | Affinity settings for pod assignment         | `{}`                                                    |
| `tolerations`                    | Toleration labels for pod assignment         | `[]`                                                    |
| `rabbitmq.enabled`               | Install RabbitMQ chart                       | `false`                                                 |
| `rabbitmq.imagePullPolicy`       | RabbitMQ image pull policy                   | `Always` if `imageTag` is `latest`, else `IfNotPresent` |
| `rabbitmq.persistence.enabled`   | Persist data to a PV                         | `true`                                                  |
| `rabbitmq.rabbitmq.username`     | Username of new user to create               | `user`                                                  |
| `rabbitmq.rabbitmq.password`     | Password for the new user                    | `""`                                                    |
| `rabbitmq.rabbitmq.erlangCookie` | RabbitMQ cluster cookie                      | `""`                                                    |
| `rabbitmq.service.port`          | PostgreSQL service TCP port                  | `5672`                                                  |
| `rabbitmq.service.tlsPort`       | PostgreSQL service TCP port                  | `5671`                                                  |
| `rabbitmq.resources`             | PostgreSQL resource requests and limits      | Memory: `512Mi`, CPU: `100m`                            |
| `postgresql.enabled`             | Install PostgreSQL chart                     | `false`                                                 |
| `postgresql.imagePullPolicy`     | PostgreSQL image pull policy                 | `Always` if `imageTag` is `latest`, else `IfNotPresent` |
| `postgresql.persistence.enabled` | Persist data to a PV                         | `false`                                                 |
| `postgresql.postgresqlUsername`  | Username of new user to create               | `prisma`                                                |
| `postgresql.postgresqlPassword`  | Password for the new user                    | `""`                                                    |
| `postgresql.postgresqlDatabase`  | Username of new user to create               | `prisma`                                                |
| `postgresql.service.port`        | PostgreSQL service TCP port                  | `5432`                                                  |
| `postgresql.resources`           | PostgreSQL resource requests and limits      | Memory: `256Mi`, CPU: `100m`                            |

Additional configuration parameters for the Redis chart deployed with Gorse can be found [here](https://github.com/bitnami/charts/tree/master/bitnami/redis).

Additional configuration parameters for the PostgreSQL chart deployed with Gorse can be found [here](https://github.com/bitnami/charts/tree/master/bitnami/postgresql).

> **Tip**: You can use the default [values.yaml](values.yaml). this will auto generate some secrets.
