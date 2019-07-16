provider "aws {

}

resource "aws_instance" "cicdvm" {

provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
  
}
