# elabFTW Helm Chart

## Introduction

> **Beta status:** This chart is currently in the BETA stage of development. It is functional and suitable for testing and evaluation, but may still contain breaking changes or configuration changes in future releases. Thorough testing is recommended before using it in production workloads.

---

## Parameters

### Global parameters

| Name              | Description                                          | Value           |
| ----------------- | ---------------------------------------------------- | --------------- |
| `global.timezone` | Timezone used by application containers and services | `Europe/Vienna` |

### eLabFTW configuration

| Name                                                  | Description                                                                                                      | Value                 |
| ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | --------------------- |
| `elabftw.siteUrl`                                     | Canonical URL of the eLabFTW instance, including scheme and optional non-standard port. Use the user-facing URL. | `""`                  |
| `elabftw.serverName`                                  | Server name used by the internal nginx configuration                                                             | `elabftw.example.com` |
| `elabftw.disableHttps`                                | Disable HTTPS inside the container. Useful when TLS is terminated by an external reverse proxy.                  | `false`               |
| `elabftw.enableLetsencrypt`                           | Enable automatic Let's Encrypt certificate handling. Has no effect when HTTPS is disabled.                       | `false`               |
| `elabftw.uploads.maxSize`                             | Maximum size allowed for uploaded files                                                                          | `100M`                |
| `elabftw.uploads.maxTime`                             | Maximum upload time in milliseconds                                                                              | `900000`              |
| `elabftw.php.memoryLimit`                             | Maximum amount of memory available to PHP scripts                                                                | `256M`                |
| `elabftw.php.maxChildren`                             | Maximum number of PHP-FPM child processes                                                                        | `50`                  |
| `elabftw.php.maxExecutionTime`                        | Maximum execution time of PHP scripts in seconds                                                                 | `300`                 |
| `elabftw.features.autoDbInit`                         | Automatically install the database structure on container start                                                  | `false`               |
| `elabftw.features.autoDbUpdate`                       | Automatically update the database structure on container start                                                   | `false`               |
| `elabftw.features.demoMode`                           | Enable demo mode with automatic login for demo users                                                             | `false`               |
| `elabftw.features.maintenanceMode`                    | Enable maintenance mode and disable user interaction                                                             | `false`               |
| `elabftw.database.persistentConnection`               | Enable persistent MySQL database connections                                                                     | `true`                |
| `elabftw.extraEnv`                                    | Additional environment variables passed to the container                                                         | `[]`                  |
| `elabftw.secrets.existingSecret`                      |                                                                                                                  | `""`                  |
| `elabftw.secrets.secretKey`                           |                                                                                                                  | `""`                  |
| `elabftw.replicaCount`                                | Number of eLabFTW application replicas                                                                           | `1`                   |
| `elabftw.image.repository`                            | Container image repository                                                                                       | `elabftw/elabimg`     |
| `elabftw.image.tag`                                   | Container image tag                                                                                              | `""`                  |
| `elabftw.image.pullPolicy`                            | Container image pull policy                                                                                      | `IfNotPresent`        |
| `elabftw.nameOverride`                                | Override the generated resource name                                                                             | `""`                  |
| `elabftw.fullnameOverride`                            | Override the full generated resource name                                                                        | `""`                  |
| `elabftw.container.port`                              | Container port exposed by the eLabFTW image                                                                      | `443`                 |
| `elabftw.service.type`                                | Kubernetes service type                                                                                          | `ClusterIP`           |
| `elabftw.service.port`                                | Kubernetes service port                                                                                          | `443`                 |
| `elabftw.service.targetPort`                          | Container port targeted by the service                                                                           | `443`                 |
| `elabftw.ingress.enabled`                             | Enable Kubernetes ingress                                                                                        | `false`               |
| `elabftw.ingress.className`                           | Ingress controller class name                                                                                    | `""`                  |
| `elabftw.ingress.annotations`                         | Additional ingress annotations                                                                                   | `{}`                  |
| `elabftw.ingress.host`                                | Hostname used by the ingress resource                                                                            | `elabftw.example.com` |
| `elabftw.ingress.path`                                | Path routed to eLabFTW                                                                                           | `/`                   |
| `elabftw.ingress.pathType`                            | Kubernetes ingress path matching type                                                                            | `Prefix`              |
| `elabftw.ingress.tls`                                 | TLS configuration for ingress                                                                                    | `[]`                  |
| `elabftw.persistence.enabled`                         | Enable persistent storage for uploaded files                                                                     | `true`                |
| `elabftw.persistence.existingClaim`                   | Use an existing persistent volume claim                                                                          | `""`                  |
| `elabftw.persistence.accessMode`                      |                                                                                                                  | `ReadWriteMany`       |
| `elabftw.persistence.storageClass`                    | Storage class for persistent volume                                                                              | `""`                  |
| `elabftw.persistence.size`                            | Persistent volume size                                                                                           | `10Gi`                |
| `elabftw.persistence.mountPath`                       | Path where uploaded files are mounted                                                                            | `/elabftw/uploads`    |
| `elabftw.resources`                                   | Kubernetes resource requests and limits                                                                          | `{}`                  |
| `elabftw.podAnnotations`                              | Additional pod annotations                                                                                       | `{}`                  |
| `elabftw.podLabels`                                   | Additional pod labels                                                                                            | `{}`                  |
| `elabftw.nodeSelector`                                | Node selector constraints                                                                                        | `{}`                  |
| `elabftw.tolerations`                                 | Pod tolerations                                                                                                  | `[]`                  |
| `elabftw.affinity`                                    | Pod affinity rules                                                                                               | `{}`                  |
| `elabftw.updateStrategy.type`                         | Deployment update strategy. Valid values: RollingUpdate, Recreate.                                               | `RollingUpdate`       |
| `elabftw.updateStrategy.rollingUpdate.maxUnavailable` | Maximum number of Pods that can be unavailable during a RollingUpdate. Integer or percentage.                    | `0`                   |
| `elabftw.updateStrategy.rollingUpdate.maxSurge`       | Maximum number of extra Pods that can be created during a RollingUpdate. Integer or percentage.                  | `1`                   |

### Internal MySQL

| Name                                | Description                                                                                                                                           | Value                 |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| `mysql.enabled`                     | Deploy an internal MySQL database                                                                                                                     | `true`                |
| `mysql.image.registry`              | MySQL image registry                                                                                                                                  | `docker.io`           |
| `mysql.image.repository`            | MySQL image repository                                                                                                                                | `bitnamilegacy/mysql` |
| `mysql.image.tag`                   | MySQL image tag                                                                                                                                       | `9.4.0-debian-12-r1`  |
| `mysql.image.digest`                | MySQL image digest                                                                                                                                    | `""`                  |
| `mysql.auth.database`               | MySQL database name                                                                                                                                   | `elabftw`             |
| `mysql.auth.username`               | MySQL application username                                                                                                                            | `elabftw`             |
| `mysql.auth.password`               | MySQL application password                                                                                                                            | `""`                  |
| `mysql.auth.rootPassword`           | MySQL root password                                                                                                                                   | `""`                  |
| `mysql.auth.existingSecret`         | Use existing secret for password details. The secret has to contain the keys `mysql-root-password`, `mysql-replication-password` and `mysql-password` | `""`                  |
| `mysql.primary.persistence.enabled` | Enable persistent storage for MySQL data                                                                                                              | `true`                |
| `mysql.primary.persistence.size`    | Persistent volume size for MySQL data                                                                                                                 | `5Gi`                 |

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

### Addons

| Name                                                        | Description                                         | Value                        |
| ----------------------------------------------------------- | --------------------------------------------------- | ---------------------------- |
| `addons.chemPlugin.enabled`                                 | Deploy the eLabFTW chemistry plugin                 | `false`                      |
| `addons.chemPlugin.replicaCount`                            | Number of chemistry plugin replicas                 | `1`                          |
| `addons.chemPlugin.image.repository`                        | Container image repository                          | `elabftw/chem-plugin`        |
| `addons.chemPlugin.image.tag`                               | Container image tag                                 | `latest`                     |
| `addons.chemPlugin.image.pullPolicy`                        | Container image pull policy                         | `IfNotPresent`               |
| `addons.chemPlugin.podSecurityContext.runAsNonRoot`         | Run containers as a non-root user                   | `true`                       |
| `addons.chemPlugin.podSecurityContext.runAsUser`            | User ID used to run the container                   | `65534`                      |
| `addons.chemPlugin.podSecurityContext.seccompProfile.type`  | Seccomp profile type                                | `RuntimeDefault`             |
| `addons.chemPlugin.indigo.enabled`                          | Enable Indigo chemical structure editor integration | `true`                       |
| `addons.chemPlugin.indigo.url`                              | Indigo service URL                                  | `http://chem-plugin/`        |
| `addons.chemPlugin.fingerprinter.enabled`                   | Enable chemical fingerprint generation              | `true`                       |
| `addons.chemPlugin.fingerprinter.url`                       | Fingerprinter service URL                           | `http://chem-plugin/`        |
| `addons.chemPlugin.service.type`                            | Kubernetes service type                             | `ClusterIP`                  |
| `addons.chemPlugin.service.port`                            | Kubernetes service port                             | `80`                         |
| `addons.chemPlugin.service.targetPort`                      | Container port targeted by the service              | `8000`                       |
| `addons.chemPlugin.resources`                               | Kubernetes resource requests and limits             | `{}`                         |
| `addons.chemPlugin.podAnnotations`                          | Additional pod annotations                          | `{}`                         |
| `addons.chemPlugin.podLabels`                               | Additional pod labels                               | `{}`                         |
| `addons.chemPlugin.nodeSelector`                            | Node selector constraints                           | `{}`                         |
| `addons.chemPlugin.tolerations`                             | Pod tolerations                                     | `[]`                         |
| `addons.chemPlugin.affinity`                                | Pod affinity rules                                  | `{}`                         |
| `addons.opencloning.enabled`                                | Deploy the OpenCloning plugin                       | `false`                      |
| `addons.opencloning.replicaCount`                           | Number of OpenCloning plugin replicas               | `1`                          |
| `addons.opencloning.image.repository`                       | Container image repository                          | `manulera/opencloning`       |
| `addons.opencloning.image.tag`                              | Container image tag                                 | `v1.3.1-baseurl-opencloning` |
| `addons.opencloning.image.pullPolicy`                       | Container image pull policy                         | `IfNotPresent`               |
| `addons.opencloning.podSecurityContext.runAsNonRoot`        | Run containers as a non-root user                   | `true`                       |
| `addons.opencloning.podSecurityContext.runAsUser`           | User ID used to run the container                   | `1000`                       |
| `addons.opencloning.podSecurityContext.seccompProfile.type` | Seccomp profile type                                | `RuntimeDefault`             |
| `addons.opencloning.allowedOrigins`                         | Allowed CORS origins                                | `*`                          |
| `addons.opencloning.rootPath`                               | Base path where OpenCloning is served               | `/opencloning`               |
| `addons.opencloning.backendUrl`                             | Backend URL exposed to the frontend                 | `/opencloning/`              |
| `addons.opencloning.showAppBar`                             | Show the application navigation bar                 | `false`                      |
| `addons.opencloning.url`                                    | OpenCloning service URL used by eLabFTW             | `http://opencloning/`        |
| `addons.opencloning.service.type`                           | Kubernetes service type                             | `ClusterIP`                  |
| `addons.opencloning.service.port`                           | Kubernetes service port                             | `80`                         |
| `addons.opencloning.service.targetPort`                     | Container port targeted by the service              | `8000`                       |
| `addons.opencloning.resources`                              | Kubernetes resource requests and limits             | `{}`                         |
| `addons.opencloning.podAnnotations`                         | Additional pod annotations                          | `{}`                         |
| `addons.opencloning.podLabels`                              | Additional pod labels                               | `{}`                         |
| `addons.opencloning.nodeSelector`                           | Node selector constraints                           | `{}`                         |
| `addons.opencloning.tolerations`                            | Pod tolerations                                     | `[]`                         |
| `addons.opencloning.affinity`                               | Pod affinity rules                                  | `{}`                         |

### Internal Redis

| Name                                   | Description                                                | Value                 |
| -------------------------------------- | ---------------------------------------------------------- | --------------------- |
| `redis.enabled`                        | Deploy an internal Redis instance and enable Redis support | `false`               |
| `redis.image.registry`                 | Redis image registry                                       | `docker.io`           |
| `redis.image.repository`               | Redis image repository                                     | `bitnamilegacy/redis` |
| `redis.image.tag`                      | Redis image tag                                            | `8.2.1-debian-12-r0`  |
| `redis.image.digest`                   | Redis image digest                                         | `""`                  |
| `redis.auth.enabled`                   | Enable Redis authentication                                | `true`                |
| `redis.auth.password`                  | Redis password                                             | `""`                  |
| `redis.auth.existingSecret`            | Existing secret containing the Redis password              | `""`                  |
| `redis.auth.existingSecretPasswordKey` | Key containing the Redis password in the existing secret   | `redis-password`      |
| `redis.master.persistence.enabled`     | Enable persistent storage for Redis                        | `true`                |
| `redis.master.persistence.size`        | Persistent volume size for Redis                           | `1Gi`                 |

### External Redis

| Name                           | Description                                     | Value      |
| ------------------------------ | ----------------------------------------------- | ---------- |
| `externalRedis.enabled`        | Enable use of an external Redis server          | `false`    |
| `externalRedis.host`           | Hostname or IP address of external Redis server | `""`       |
| `externalRedis.port`           | Redis server port                               | `6379`     |
| `externalRedis.username`       | Redis username                                  | `""`       |
| `externalRedis.password`       | Redis password                                  | `""`       |
| `externalRedis.existingSecret` | Existing secret containing Redis credentials    | `""`       |
| `externalRedis.usernameKey`    | Key containing the Redis username               | `username` |
| `externalRedis.passwordKey`    | Key containing the Redis password               | `password` |

This Helm chart is distributed as an **OCI-based Helm chart** using **GitHub Container Registry (GHCR)**.

OCI-based Helm charts are installed directly from the registry using the `oci://` URL scheme.  
No `helm repo add` or `helm repo update` commands are required.

## Basic Installation with Default Configuration

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
    secretKey: "REPLACE_WITH_RANDOM_SECRET_KEY"

mysql:
  enabled: true
  auth:
    rootPassword: "REPLACE_WITH_MYSQL_ROOT_PASSWORD"
    password: "REPLACE_WITH_MYSQL_PASSWORD"
    database: "elabftw"
    username: "elabftw"
```

> Replace all `REPLACE_WITH_*` values before installing. Do not deploy with the example values.

> The chart will create the required Kubernetes Secrets during installation using the values provided above.
as
> For production environments, consider using pre-created Kubernetes Secrets and reference them instead of storing credentials in `values.yaml`.


Install the chart with the custom configuration:
```bash
helm install elabftw \
  oci://ghcr.io/tugraz-rdm/elabftw \
  --namespace elabftw \
  --create-namespace \
  --values values.yaml
```

---

## Testing

This chart uses the [helm-unittest](https://github.com/helm-unittest/helm-unittest) plugin to run unit tests for Helm templates.

The tests verify that the templates in `templates/` render the expected Kubernetes resources based on different `values.yaml` configurations.
### Install helm-unittest plugin

```bash
helm plugin install https://github.com/helm-unittest/helm-unittest
```

### Run chart tests

Run all unit tests for the eLabFTW chart:

```bash
helm unittest charts/elabftw
```
