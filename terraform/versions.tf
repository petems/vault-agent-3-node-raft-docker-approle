terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "1.4.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "2.14.0"
    }
  }
  required_version = ">= 0.13"
}
