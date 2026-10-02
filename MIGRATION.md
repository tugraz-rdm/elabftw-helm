# Migration from v5 to v6

## What changed

Version 6 updates the eLabFTW container to run with a different user and filesystem permissions.

The following directories must be writable by the eLabFTW worker user:

* `/elabftw/uploads`
* `/elabftw/exports`
* `/elabftw/cache`

The directories should be owned by UID/GID `1002:1002`.

## Before upgrading

While **v5 is still running**, create the required directories and set their ownership.

### 1. Set ownership of the existing uploads directory

The existing uploads directory contains persistent data, so change its ownership to `1002:1002`:

```bash
kubectl -n elabftw exec <elabftw-pod> -- \
  chown -R 1002:1002 /elabftw/uploads
```

For example:

```bash
kubectl -n elabftw exec elabftw-679d4b45b5-mfzqn -- \
  chown -R 1002:1002 /elabftw/uploads
```

### 2. Create the exports directory

Create the directory if it does not already exist and give it the required ownership:

```bash
kubectl -n elabftw exec <elabftw-pod> -- \
  sh -c 'mkdir -p /elabftw/exports && chown -R 1002:1002 /elabftw/exports'
```

### 3. Create the cache directory

Create the cache directory and give it the required ownership:

```bash
kubectl -n elabftw exec <elabftw-pod> -- \
  sh -c 'mkdir -p /elabftw/cache && chown -R 1002:1002 /elabftw/cache'
```

### 4. Verify ownership

Check all three directories:

```bash
kubectl -n elabftw exec <elabftw-pod> -- \
  ls -ldn /elabftw/uploads /elabftw/exports /elabftw/cache
```

Expected ownership:

```text
1002 1002 /elabftw/uploads
1002 1002 /elabftw/exports
1002 1002 /elabftw/cache
```

> **Important:** Perform these steps before upgrading to v6, while the v5 pod is still running.

## Upgrade to v6

After creating the required directories and setting their ownership, upgrade the Helm release:

```bash
helm upgrade elabftw . \
  --namespace elabftw \
  --values values.yaml \
  --wait
```

The existing uploads and other persistent data remain in place.

## Verify after the upgrade

Verify that the v6 pod is running:

```bash
kubectl -n elabftw get pods
```

Verify the ownership from the new container:

```bash
kubectl -n elabftw exec <elabftw-pod> -- \
  ls -ldn /elabftw/uploads /elabftw/exports /elabftw/cache
```

Also verify that eLabFTW can write to the required directories.

## Summary

1. Keep eLabFTW v5 running.
2. Change `/elabftw/uploads` ownership to `1002:1002`.
3. Create `/elabftw/exports` and set ownership to `1002:1002`.
4. Create `/elabftw/cache` and set ownership to `1002:1002`.
5. Verify ownership of all three directories.
6. Upgrade the Helm release to v6.
7. Verify that eLabFTW starts successfully.
8. Verify that existing uploads are accessible and exports/cache are writable.
