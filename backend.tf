terraform {
  cloud {
    organization = "grayburnd"

    workspaces {
      name = "web-network-dev"
    }
  }
}