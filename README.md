# Hack RHODS

Q: How hard is it to make RHODS run any OpenShift Cluster?

A: ...


## Hacks

Note: Repeat commands if you see errors
```
hacks/run.sh
```

Extracting catalogs / install plan
```
opm alpha bundle unpack quay.io/modh/rhods-bundle:v1.15.0-10
opm migrate quay.io/modh/qe-catalog-source:v1.15.0-10 -o yaml ./
```

## Comments
- Does this operator meet standards to be in the marketplace?
- Operater install should NOT fail
  - Operator is kubeflow NOT `deploy.sh`
- `deploy.sh` is **kludgee**
  - Avoid `initContainer` for operator or deployment
  - Script could be more modular
  - Create functions
  - Mixture of imparative and declaritive operations (pick declaritive)
  - Do NOT `exit 1`
    - The operator has NOT failed, the deployment failed
  - Do NOTHING vs `exit 1`
    - Order of operation and scope issues for SRE logic
  - FIX: Use regular container for `deploy.sh`
- `buildchain.sh` is **kludgee**
  - Can NOT use JupyterHub for 40+ mins after deployment
  - Use declaritive methods
  - FIX: Build containers in CI and push to quay.io
  - FEATURE: Chain build with customizations - Create template for users?
- No operator health checks



## Links
- [GitHub - RHODS Operator](https://github.com/red-hat-data-services/opendatahub-operator)
- [GitHub - RHODS Deployer](https://github.com/red-hat-data-services/odh-deployer)