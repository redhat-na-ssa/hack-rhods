# Hack RHODS

Q: How hard is it to make RHODS run any OpenShift Cluster?

A: ...


## Quickstart

Note: Repeat commands if you see errors
```
oc apply -f k8s
oc apply -k components/operators/rhods/operator/overlays/beta
```

## Hacks

Make RHODS hybrid cloud ready - run on any OCP
```
[ ! -e generated ] && mkdir generated

# create our patched deploy script for the rhods operator
oc --dry-run=client -o yaml \
  -n redhat-ods-operator \
  create configmap hack-rhods-deployer \
  --from-file hacks/deploy.sh \
  > generated/hack-rhods-deployer-cm.yaml

# create a modified operator that uses our script
oc apply -f generated/hack-rhods-deployer-cm.yaml

# redeploy - just in case
oc apply -f k8s

# check maximum effort
diff -u dump/deployer-v1.15.0-10/sdeploy.sh hacks/deploy.sh

# Success!!!1
```

## Comments
- What is the value add for RHODS vs ODH?
  - What exactly makes us think we can charge for RHODS vs ODH?
- Chained build for Jupyter containers?
  - Can NOT use JupyterHub for 30+ mins after deployment
  - Chain build with customizations - Create template for users?

## Links
- [GitHub - RHODS Operator](https://github.com/red-hat-data-services/opendatahub-operator)
- [GitHub - RHODS Deployer](https://github.com/red-hat-data-services/odh-deployer)