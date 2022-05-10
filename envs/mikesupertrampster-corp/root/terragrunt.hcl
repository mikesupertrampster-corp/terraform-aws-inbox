include {
  path = find_in_parent_folders()
}


inputs = {
  apex_domain       = "mikesupertrampster.com"
  environment       = "root"
  forwarding_emails = ["mikesupertrampster@gmail.com"]
  tags              = { Environment = "root", Managed_By = "Terraform" }
}
