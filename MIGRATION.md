# Migration from v5 to v6

## Prepare the existing data

Before deploying eLabFTW v6, update the permissions on the existing v5 persistent volume.

The v5 PVC currently contains the uploaded files directly in the PVC root:

```text
PVC
├── b7/
├── ce/
└── exports/
```

**Do not create an additional `uploads/` directory.** The existing `b7/`, `ce/`, and other upload directories must remain where they are.


Run the following command while the v5 pod is still running:

```bash
kubectl -n elabftw exec <elabftw-pod> -- sh -c \
  'mkdir -p /elabftw/uploads/exports && \
   chown -R 1002:100 /elabftw/uploads /elabftw/uploads/exports && \
   chmod -R g+rwX /elabftw/uploads /elabftw/uploads/exports'
```

This will:

* Keep the existing uploaded files in their current location.
* Create the `exports/` directory if it does not already exist.
* Set ownership to `1002:100`.
* Grant the owner and group read/write access while preserving execute permissions on directories.


Verify the directory structure

Check that the existing upload directories are still present:

```bash
kubectl -n elabftw exec elabftw-679d4b45b5-npfm2 -- \
  ls -la /elabftw/uploads
```

Expected structure:

```text
/elabftw/uploads/
├── b7/
├── ce/
└── exports/
```

Verify the `exports` directory permissions:

```bash
kubectl -n elabftw exec elabftw-679d4b45b5-npfm2 -- \
  ls -ld /elabftw/uploads/exports
```

Expected:
```text
drwxrwxr-x ... 1002 users ... /elabftw/uploads/exports
```
