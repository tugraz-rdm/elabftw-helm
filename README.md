# elabFTW Helm Chart

## Introduction

> **Alpha status:** This chart is currently in the ALPHA stage of development. It is functional but may contain incomplete features, breaking changes, or configuration changes in future releases. It is not yet recommended for production workloads without thorough testing.

---

## Parameters

### Global parameters

| Name              | Description                                          | Value           |
| ----------------- | ---------------------------------------------------- | --------------- |
| `global.timezone` | Timezone used by application containers and services | `Europe/Vienna` |

### eLabFTW configuration

| Name                                    | Description                                                                                                      | Value                 |
| --------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | --------------------- |
| `elabftw.siteUrl`                       | Canonical URL of the eLabFTW instance, including scheme and optional non-standard port. Use the user-facing URL. | `""`                  |
| `elabftw.serverName`                    | Server name used by the internal nginx configuration                                                             | `elabftw.example.com` |
| `elabftw.disableHttps`                  | Disable HTTPS inside the container. Useful when TLS is terminated by an external reverse proxy.                  | `false`               |
| `elabftw.enableLetsencrypt`             | Enable automatic Let's Encrypt certificate handling. Has no effect when HTTPS is disabled.                       | `false`               |
| `elabftw.uploads.maxSize`               | Maximum size allowed for uploaded files                                                                          | `100M`                |
| `elabftw.uploads.maxTime`               | Maximum upload time in milliseconds                                                                              | `900000`              |
| `elabftw.php.memoryLimit`               | Maximum amount of memory available to PHP scripts                                                                | `256M`                |
| `elabftw.php.maxChildren`               | Maximum number of PHP-FPM child processes                                                                        | `50`                  |
| `elabftw.php.maxExecutionTime`          | Maximum execution time of PHP scripts in seconds                                                                 | `300`                 |
| `elabftw.features.autoDbInit`           | Automatically install the database structure on container start                                                  | `false`               |
| `elabftw.features.autoDbUpdate`         | Automatically update the database structure on container start                                                   | `false`               |
| `elabftw.features.demoMode`             | Enable demo mode with automatic login for demo users                                                             | `false`               |
| `elabftw.features.maintenanceMode`      | Enable maintenance mode and disable user interaction                                                             | `false`               |
| `elabftw.database.persistentConnection` | Enable persistent MySQL database connections                                                                     | `true`                |
| `elabftw.redis.enabled`                 | Enable Redis support for PHP session storage                                                                     | `false`               |
| `elabftw.redis.host`                    | Redis server hostname or IP address                                                                              | `redis`               |
| `elabftw.redis.port`                    | Redis server port                                                                                                | `6379`                |
| `elabftw.redis.username`                | Redis username                                                                                                   | `""`                  |
| `elabftw.redis.password`                | Redis password                                                                                                   | `""`                  |
| `elabftw.redis.existingSecret`          |                                                                                                                  | `""`                  |
| `elabftw.redis.passwordKey`             | Key containing the Redis password in the existing secret                                                         | `password`            |
| `elabftw.extraEnv`                      | Additional environment variables passed to the container                                                         | `[]`                  |
| `elabftw.secrets.existingSecret`        |                                                                                                                  | `""`                  |
| `elabftw.secrets.secretKey`             |                                                                                                                  | `""`                  |
| `elabftw.replicaCount`                  | Number of eLabFTW application replicas                                                                           | `1`                   |
| `elabftw.image.repository`              | Container image repository                                                                                       | `elabftw/elabimg`     |
| `elabftw.image.tag`                     | Container image tag                                                                                              | `""`                  |
| `elabftw.image.pullPolicy`              | Container image pull policy                                                                                      | `IfNotPresent`        |
| `elabftw.nameOverride`                  | Override the generated resource name                                                                             | `""`                  |
| `elabftw.fullnameOverride`              | Override the full generated resource name                                                                        | `""`                  |
| `elabftw.container.port`                | Container port exposed by the eLabFTW image                                                                      | `443`                 |
| `elabftw.service.type`                  | Kubernetes service type                                                                                          | `ClusterIP`           |
| `elabftw.service.port`                  | Kubernetes service port                                                                                          | `443`                 |
| `elabftw.service.targetPort`            | Container port targeted by the service                                                                           | `443`                 |
| `elabftw.ingress.enabled`               | Enable Kubernetes ingress                                                                                        | `false`               |
| `elabftw.ingress.className`             | Ingress controller class name                                                                                    | `""`                  |
| `elabftw.ingress.annotations`           | Additional ingress annotations                                                                                   | `{}`                  |
| `elabftw.ingress.host`                  | Hostname used by the ingress resource                                                                            | `elabftw.example.com` |
| `elabftw.ingress.path`                  | Path routed to eLabFTW                                                                                           | `/`                   |
| `elabftw.ingress.pathType`              | Kubernetes ingress path matching type                                                                            | `Prefix`              |
| `elabftw.ingress.tls`                   | TLS configuration for ingress                                                                                    | `[]`                  |
| `elabftw.persistence.enabled`           | Enable persistent storage for uploaded files                                                                     | `true`                |
| `elabftw.persistence.existingClaim`     | Use an existing persistent volume claim                                                                          | `""`                  |
| `elabftw.persistence.accessMode`        |                                                                                                                  | `ReadWriteMany`       |
| `elabftw.persistence.storageClass`      | Storage class for persistent volume                                                                              | `""`                  |
| `elabftw.persistence.size`              | Persistent volume size                                                                                           | `20Gi`                |
| `elabftw.persistence.mountPath`         | Path where uploaded files are mounted                                                                            | `/elabftw/uploads`    |
| `elabftw.resources`                     | Kubernetes resource requests and limits                                                                          | `{}`                  |
| `elabftw.podAnnotations`                | Additional pod annotations                                                                                       | `{}`                  |
| `elabftw.podLabels`                     | Additional pod labels                                                                                            | `{}`                  |
| `elabftw.nodeSelector`                  | Node selector constraints                                                                                        | `{}`                  |
| `elabftw.tolerations`                   | Pod tolerations                                                                                                  | `[]`                  |
| `elabftw.affinity`                      | Pod affinity rules                                                                                               | `{}`                  |

### Internal MySQL

| Name                                | Description                                                   | Value                 |
| ----------------------------------- | ------------------------------------------------------------- | --------------------- |
| `mysql.enabled`                     | Deploy an internal MySQL database                             | `false`               |
| `mysql.image.registry`              | MySQL image registry                                          | `docker.io`           |
| `mysql.image.repository`            | MySQL image repository                                        | `bitnamilegacy/mysql` |
| `mysql.image.tag`                   | MySQL image tag                                               | `9.4.0-debian-12-r1`  |
| `mysql.image.digest`                | MySQL image digest                                            | `""`                  |
| `mysql.auth.database`               | MySQL database name                                           | `elabftw`             |
| `mysql.auth.username`               | MySQL application username                                    | `elabftw`             |
| `mysql.auth.password`               | MySQL application password                                    | `""`                  |
| `mysql.auth.rootPassword`           | MySQL root password                                           | `""`                  |
| `mysql.auth.existingSecret`         |                                                               | `""`                  |
| `mysql.auth.usernameKey`            | Key containing the MySQL username in the existing secret      | `username`            |
| `mysql.auth.passwordKey`            | Key containing the MySQL password in the existing secret      | `password`            |
| `mysql.auth.rootPasswordKey`        | Key containing the MySQL root password in the existing secret | `mysql-root-password` |
| `mysql.primary.persistence.enabled` | Enable persistent storage for MySQL data                      | `true`                |
| `mysql.primary.persistence.size`    | Persistent volume size for MySQL data                         | `5Gi`                 |

### External MySQL

| Name                              | Description                                                 | Value      |
| --------------------------------- | ----------------------------------------------------------- | ---------- |
| `externalDatabase.host`           | Hostname or IP address of external MySQL server             | `""`       |
| `externalDatabase.port`           | MySQL server port                                           | `3306`     |
| `externalDatabase.database`       | MySQL database name                                         | `elabftw`  |
| `externalDatabase.username`       | MySQL username                                              | `elabftw`  |
| `externalDatabase.password`       | MySQL password                                              | `""`       |
| `externalDatabase.existingSecret` |                                                             | `""`       |
| `externalDatabase.usernameKey`    | Key containing the database username in the existing secret | `username` |
| `externalDatabase.passwordKey`    | Key containing the database password in the existing secret | `password` |

---

# Installation

This Helm chart is distributed as an **OCI-based Helm chart** using **GitHub Container Registry (GHCR)**.

OCI-based Helm charts are installed directly from the registry using the `oci://` URL scheme.  
No `helm repo add` or `helm repo update` commands are required.

## Basic Installation

Before installing the chart, create the required Kubernetes Secrets.


Create the namespace:

```bash
kubectl create namespace elabftw
```

Create the eLabFTW application Secret:

```bash
kubectl create secret generic elabftw-secret \
  --namespace elabftw \
  --from-literal=secret-key='your-elabftw-secret-value'
```

Create the MySQL credentials Secret:

```bash
kubectl create secret generic elabftw-mysql-secret \
  --namespace elabftw \
  --from-literal=mysql-root-password='your-root-password' \
  --from-literal=mysql-replication-password='your-replication-password' \
  --from-literal=mysql-password='your-database-password'
```

Install the eLabFTW Helm chart using the existing Secrets:

```bash
helm install elabftw \
  oci://ghcr.io/tugraz-rdm/elabftw \
  --namespace elabftw \
  --set elabftw.secrets.existingSecret=elabftw-secret \
  --set elabftw.secrets.secretKey=secret-key \
  --set mysql.auth.existingSecret=elabftw-mysql-secret
```

## Custom Values Installation

Create a custom `values.yaml` file:

```yaml
elabftw:
  siteUrl: https://elabftw.example.com
  serverName: elabftw.example.com
  features:
    autoDbInit: true
    autoDbUpdate: true

  secrets:
    secretKey: ""

mysql:
  enabled: true
  auth:
    rootPassword: ""
    password: ""
    database: ""
    username: ""

```
The chart will create the required Kubernetes Secrets during installation using the values provided above.


Install the chart with the custom configuration:
```bash
helm install elabftw \
  oci://ghcr.io/tugraz-rdm/elabftw \
  --namespace elabftw \
  --create-namespace \
  --values values.yaml
```
