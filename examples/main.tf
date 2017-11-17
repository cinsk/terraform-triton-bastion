provider "triton" {
  account = "${var.triton_account_name}"
  url = "${var.triton_url}"
}

data "triton_network" "public" {
  name = "Joyent-SDC-Public"
}

data "triton_network" "fabric" {
  name = "My-Fabric-Network"
}

data "triton_network" "private" {
  name = "Joyent-SDC-Private"
}

module "bastion" {
  # source = "../modules/services/bastion"
  source = "github.com/cinsk/terraform-triton-bastion/modules/services/bastion"

  name = "bastion"

  networks = [
    "${data.triton_network.public.id}",
    "${data.triton_network.private.id}",
    "${data.triton_network.fabric.id}",
  ]
  
  private_key = "${file(pathexpand("~/.ssh/id_rsa"))}"
}
