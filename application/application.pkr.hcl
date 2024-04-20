packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
    vagrant = {
      version = "~> 1"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

source "amazon-ebs" "application" {
  ami_name       = "application-{{timestamp}}"
  instance_type  = "t2.micro"
  region         = "us-east-1"
  source_ami     = "ami-08e7fc1f154ebe598"
  communicator   = "winrm"
  user_data_file = "./bootstrap_win"
  winrm_password = "SuperS3cr3t!!!!"
  winrm_username = "Administrator"
  winrm_insecure = true
}

build {
  name    = "second-build"
  sources = ["source.amazon-ebs.application"]

  provisioner "powershell" {
  inline = [
    "git clone https://github.com/MariusLita/webApp.git",
    "cd webApp",
    "Start-Process -FilePath 'dotnet' -ArgumentList 'run' -WindowStyle Hidden"
  ]
}

  post-processor "vagrant" {}
  post-processor "compress" {}

}