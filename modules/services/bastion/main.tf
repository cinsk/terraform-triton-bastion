
data "triton_image" "bastion" {
  name = "base-64"
  type = "zone-dataset"
  most_recent = true
}


resource "triton_machine" "bastion" {
  name = "${var.name}"

  package = "g4-highcpu-1G"
  image = "${data.triton_image.bastion.id}"
  firewall_enabled = "true"

  cns {
    services = [ "${var.name}" ]
  }
  
  tags = {
    role = "bastion"
  }

  networks = [
    "${var.networks}"
  ]

  connection {
    type = "ssh"
    user = "root"
    private_key = "${var.private_key}"
    host = "${self.primaryip}"
  }
  
  provisioner "file" {
    source = "${path.module}/tmux.conf"
    destination = "/root/.tmux.conf"
  }
  
  provisioner "file" {
    source = "${path.module}/screenrc"
    destination = "/root/.screenrc"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "exec >&/var/log/terraform.provisioner.log",
  #     "yum update -y",
  #     "yum install -y nmap-ncat screen tmux"
  #   ]
  # }

  user_script = "${file("${path.module}/user-script.sh")}"
  depends_on = [ "triton_firewall_rule.bastion-22" ]
}


resource "triton_firewall_rule" "bastion-22" {
  rule = "FROM any TO tag role = bastion ALLOW tcp port 22"
  enabled = true
}


output "bastion_name" {
  value = "${triton_machine.bastion.name}"
}

output "bastion_ip" {
  value = "${triton_machine.bastion.primaryip}"
}
