include {
  path = find_in_parent_folders()
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = read_terragrunt_config(find_in_parent_folders())
}
