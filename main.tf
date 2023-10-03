terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "pod_security_policy_conflicts" {
  source    = "./modules/pod_security_policy_conflicts"

  providers = {
    shoreline = shoreline
  }
}