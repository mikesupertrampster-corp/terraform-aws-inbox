include {
  path = find_in_parent_folders()
}


inputs = {
  apex_domain    = "mikesupertrampster.com"
  environment    = "root"
  tags           = { Environment = "root", Managed_By = "Terraform" }
}
