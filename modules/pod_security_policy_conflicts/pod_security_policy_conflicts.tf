resource "shoreline_notebook" "pod_security_policy_conflicts" {
  name       = "pod_security_policy_conflicts"
  data       = file("${path.module}/data/pod_security_policy_conflicts.json")
  depends_on = [shoreline_action.invoke_pod_policy_conflict]
}

resource "shoreline_file" "pod_policy_conflict" {
  name             = "pod_policy_conflict"
  input_file       = "${path.module}/data/pod_policy_conflict.sh"
  md5              = filemd5("${path.module}/data/pod_policy_conflict.sh")
  description      = "Identify the root cause of the policy conflict. This could involve reviewing the pod security policies in place and comparing them to the requirements of the affected pod. Once the issue has been identified, the policies can be updated to resolve the conflict."
  destination_path = "/agent/scripts/pod_policy_conflict.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_pod_policy_conflict" {
  name        = "invoke_pod_policy_conflict"
  description = "Identify the root cause of the policy conflict. This could involve reviewing the pod security policies in place and comparing them to the requirements of the affected pod. Once the issue has been identified, the policies can be updated to resolve the conflict."
  command     = "`chmod +x /agent/scripts/pod_policy_conflict.sh && /agent/scripts/pod_policy_conflict.sh`"
  params      = ["POLICY_NAME","POD_NAME","UPDATED_POLICY_YAML","NAMESPACE"]
  file_deps   = ["pod_policy_conflict"]
  enabled     = true
  depends_on  = [shoreline_file.pod_policy_conflict]
}

