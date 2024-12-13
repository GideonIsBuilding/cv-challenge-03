resource "null_resource" "ansible" {
    provisioner "remote-exec" {
    connection {
        host = data.aws_eip.dojo-eip.public_ip
        user = "ubuntu"
        private_key = file("${path.module}/nginix.pem")
    }

    inline = ["echo 'connected!'"]
    }
    provisioner "local-exec" {
        command = "ansible-playbook -i ${path.module}/../ansible/inventory ${path.module}/../ansible/playbook.yml --tags monitoring --extra-vars '@${path.module}/../ansible/vars/docker_hub.yml'"
    }

    depends_on = [ aws_instance.app ]
}
