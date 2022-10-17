#!/bin/bash

[ ! -e generated ] && mkdir generated

# create objects
oc apply -k components/operators/rhods/operator/overlays/beta

# let things settle
sleep 30

# create our patched deploy script for the rhods operator
oc --dry-run=client -o yaml \
  -n redhat-ods-operator \
  create configmap hack-rhods-deployer \
  --from-file hacks/deploy.sh \
  > generated/hack-rhods-deployer-cm.yaml

# create a modified operator that uses our script
oc apply -f generated/hack-rhods-deployer-cm.yaml

# hack rhods operator w/ configmap
oc apply -f hacks
sleep 10

# delete old operator deployment
# oc -n redhat-ods-operator delete deployment rhods-operator
oc -n redhat-ods-operator delete po -l name=rhods-operator
