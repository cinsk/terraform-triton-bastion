
# Terraform Module for Bastion server in Triton

This package contains a Terraform module definition for creating a Bastion server in [Joyent Triton Cloud](https://www.joyent.com/).


## How to use this module

* `module/` contains the Terraform module for a Bastion server in Triton
* `example/` contains the example Terraform configuration to launch a Bastion server.


1. `cd example/`
2. `cp terraform.tfvars.example terraform.tfvars`
3. Update `terraform.tfvars` to match your Triton environment.
   1. `triton_url` -- Run `triton profile get` and get the value of the field, "url".
   2. `triton_region` -- Run `triton profile get` and get the value of the field, "name".
   3. `triton_account_name` -- Run `triton profile get` and get the value of the field, "account".
   4. `triton_account_uuid` -- Run `triton account get` and get the value of the field, "id".

4. Update module variable in `main.tf`:
   1. `name` -- The Triton machine name of the Bastion server.
   1. `networks` -- Arrays of Triton network that the Bastion instances will join.
   2. `private_key` -- Private key for the public key authentication for connecting the instance.
   
5. Run `terraform get && terraform init && terraform plan` to see the execution plan.
6. Run `terraform apply` to deploy the Consul cluster.
7. Run `terraform destroy` if you want to delete the cluster.

