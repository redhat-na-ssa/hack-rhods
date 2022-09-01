# Hack RHODS

Q: How hard is it to make RHODS run any OpenShift Cluster?

A: ...


## Quickstart

```
oc apply -f k8s
oc apply -k components/operators/rhods/operator/overlays/beta
```

## Hacks

"Fix" the operator
```
mkdir generated

oc --dry-run=client -o yaml \
  -n redhat-ods-operator \
  create configmap fix-deploy \
  --from-file hacks/deploy.sh \
  > generated/fix-deploy-cm.yaml

oc apply -f generated/fix-deploy-cm.yaml 

```

## Comments
- What is the value add for RHODS vs ODH?
  - What exactly makes us think we can charge for RHODS vs ODH?