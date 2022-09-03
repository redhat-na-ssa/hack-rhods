# Hack RHODS

Q: How hard is it to make RHODS run any OpenShift Cluster?

A: ...


## Hacks

Note: Repeat commands if you see errors
``````
hacks/run.sh
```

Extracting catalogs / install plan
```
opm alpha bundle unpack quay.io/modh/rhods-bundle:v1.15.0-10
opm migrate quay.io/modh/qe-catalog-source:v1.15.0-10 -o yaml ./
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