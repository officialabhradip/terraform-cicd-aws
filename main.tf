provider "aws {
access_key = ""
secret_key = ""
region = ""
}

resource "aws_instance" "cicdvm" {
ami = ""
instance_type = ""
root_block_device{
volume_size = "50"
}
provisioner "remote-exec" {
    inline = [
        "wget https://apt.puppetlabs.com/pupetlabs-release-pc1-xenial.deb"
        "sudo dpkg -i pupetlabs-release-pc1-xenial.deb"
        "sudo apt-get update"
        "sudo apt-get install -y puppet-agent git"
        "sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet"
        "sudo puppet module install rtyler-jenkins"
        "sudo puppet module install hubspot-nexus"
        "sudo puppet module install maestrodev-sonarqube"
        "wget https://raw.githubusercontent.com/officialabhradip/terraform-cicd-aws/master/jenkins.pp"
        "wget https://raw.githubusercontent.com/officialabhradip/terraform-cicd-aws/master/nexus.pp"
        "wget sonar.pp"
        "sudo puppet apply jenkins.pp"
        "sudo apt-get install -y maven"
        "sudo puppet apply nexus.pp"
        "sudo puppet apply sonar.pp"
        "sudo echo 'sonar.embeddedDatabase.port:        9092' >> /usr/local/sonar/conf/sonar.properties"
        "sudo /etc/init.d/sonar start"
        "sudo rm -f /etc/maven/settings.xml"
        "sudo wget settings.xml -O /etc/maven/settings.xml"
    ]
  }
  
}
