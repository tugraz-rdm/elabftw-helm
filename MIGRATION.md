# Migration from v5 to v6

## What changed

Version 6 updates the eLabFTW container to run with a different user and filesystem permissions.

The `/elabftw/uploads` directory must be owned by UID/GID `1002:1002` so that eLabFTW can access uploaded files after the upgrade.

## Before upgrading

While **v5 is still running**, change the ownership of the existing uploads directory:

```bash
kubectl -n elabftw exec <elabftw-pod> -- \
  chown -R 1002:1002 /elabftw/uploads
```

For example:

```
kubectl -n elabftw exec elabftw-679d4b45b5-mfzqn -- \
  chown -R 1002:1002 /elabftw/uploads
```
- Important: Perform this step before upgrading to v6, while the v5 pod is still running.

## Upgrade to v6

After changing the ownership, upgrade the Helm release:

```bash
helm upgrade elabftw . \
  --namespace elabftw \
  --values values.yaml \
  --wait
```
The existing uploads and other persistent data remain in place.

## Summary

1. Keep eLabFTW v5 running.

2. Change /elabftw/uploads ownership to 1002:1002.

3. Upgrade the Helm release to v6.

4.  Verify that eLabFTW starts successfully and existing uploads are accessible.
