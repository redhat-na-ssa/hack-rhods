#!/bin/bash

delete_rhods(){
  
  ns=(redhat-ods-applications redhat-ods-monitoring rhods-notebooks redhat-ods-operator)
  for i in "${ns[@]}"
  do

    # delete kfdefs
    oc -n $i \
      delete kfdefs.kfdef.apps.kubeflow.org --wait=false --all
    sleep 1

    # delete kfdefs - forced
    oc -n $i \
      get kfdefs.kfdef.apps.kubeflow.org \
      -o json | jq '.items[].metadata.finalizers = null' | oc apply -f -
  done

  
  crd_labeled=$(oc get crd -l app=rhods-dashboard -o name)
  oc delete ${crd_labeled}

  ns_labeled=$(oc get ns -l opendatahub.io/generated-namespace -o name)
  oc delete ${ns_labeled}

  ns=(anonymous redhat-ods-applications redhat-ods-monitoring rhods-notebooks redhat-ods-operator)
  for i in "${ns[@]}"
  do
    oc delete ns $i  
  done
}

delete_rhods