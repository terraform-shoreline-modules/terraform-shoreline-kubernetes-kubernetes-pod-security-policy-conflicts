
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Pod Security Policy Conflicts
---

Pod security policy conflicts refer to situations where there are security policy violations in Kubernetes pods. This can happen when pod security policies are not properly defined or when the policies in place conflict with the requirements of a specific pod. These conflicts can result in the pod being denied access to resources, which can cause serious disruptions in the application or system running on the pod.

### Parameters
```shell
export POD_NAME="PLACEHOLDER"

export KUBE_APISERVER_POD_NAME="PLACEHOLDER"

export UPDATED_POLICY_YAML="PLACEHOLDER"

export NAMESPACE="PLACEHOLDER"

export POLICY_NAME="PLACEHOLDER"
```

## Debug

### Check the status of the pod
```shell
kubectl get pod ${POD_NAME}
```

### View the pod's security policies
```shell
kubectl describe pod ${POD_NAME}
```

### Check the status of the security policies
```shell
kubectl get podsecuritypolicies
```

### Check the status of the security context constraints
```shell
kubectl get scc
```

### Check the logs for the pod
```shell
kubectl logs ${POD_NAME}
```

### Check the events related to the pod
```shell
kubectl get events --field-selector involvedObject.name=${POD_NAME}
```

### Check the audit logs for the Kubernetes API server
```shell
kubectl logs -n kube-system ${KUBE_APISERVER_POD_NAME} | grep -i audit
```

## Repair

### Identify the root cause of the policy conflict. This could involve reviewing the pod security policies in place and comparing them to the requirements of the affected pod. Once the issue has been identified, the policies can be updated to resolve the conflict.
```shell


#!/bin/bash



# Set variables

POD_NAME=${POD_NAME}

NAMESPACE=${NAMESPACE}

POLICY_NAME=${POLICY_NAME}



# Get policy details

POLICY_DETAILS=$(kubectl get podsecuritypolicy $POLICY_NAME -o json)



# Get pod details

POD_DETAILS=$(kubectl get pod $POD_NAME -n $NAMESPACE -o json)



# Check for policy conflicts

if kubectl auth reconcile $POLICY_DETAILS $POD_DETAILS > /dev/null 2>&1; then

    echo "No policy conflicts found."

else

    # Update policy

    kubectl apply -f ${UPDATED_POLICY_YAML}

    echo "Policy updated successfully."

fi


```