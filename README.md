# Make RHODS work on OpenShift

## Origin Story
Q: How hard is it to make RHODS run any OpenShift Cluster?

A: ...

The purpose of this repo is to understand how RHODS works and how much effort it takes to make RHODS work in other cloud providers (ex: ARO, baremetal). Currently RHODS is only available in ROSA (AWS).

Disclaimer: The `make-things-work` method was applied here - YMMV, unsupported solution, godspeed, etc...

## Hacks

Note: Repeat command if you see errors
```
# run RHODS in an unsupported fashion = YES
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
  - Do NOT Deploy `postgres` in RDS (AWS) - fragile
    - FIX: Deploy `postgres` in OpenShift
  - Do NOT `exit 1`
    - The operator has NOT failed, the deployment failed
  - Do NOTHING vs `exit 1`
    - Order of operation and scope issues for SRE logic
  - FIX: Use regular container for `deploy.sh`
- `buildchain.sh` is **kludgee**
  - Build configs resources very oversized (fix: 1 cpu, 2Gi)
  - Can NOT use JupyterHub for 40+ mins after deployment
  - Use declaritive methods
  - FIX: Build containers in CI and push to quay.io
  - FEATURE: Chain build with customizations - Create template for users?
- No operator health checks

## Opinions / Conclusions
- It will be difficult to sell the value of RHODS vs ODH
  - Customers will be buying an idea / relationship vs a solution
- Give RHODS for free (until it's more valuable than ODH)
- Sell ROSA (Give RHODS for free)
- Features for RHODS come slowly
- Downgrade operator channel to `alpha` OR Fix above issues

 
## Links
- [GitHub - RHODS Operator](https://github.com/red-hat-data-services/opendatahub-operator)
- [GitHub - RHODS Deployer](https://github.com/red-hat-data-services/odh-deployer)
