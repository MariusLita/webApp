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

source "amazon-ebs" "prerequisites" {
  access_key     = "ss"
  secret_key     = "ddd"
  ami_name       = "prerequisites-{{timestamp}}"
  instance_type  = "t2.micro"
  region         = "us-east-1"
  source_ami     = "ami-0a62069ec7788c8be"
  communicator   = "winrm"
  user_data_file = "./bootstrap_win"
  winrm_password = "SuperS3cr3t!!!!"
  winrm_username = "Administrator"
  winrm_insecure = true
}

build {
  name    = "my-first-build"
  sources = ["source.amazon-ebs.prerequisites"]

  provisioner "powershell" {
    inline = [
      "Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression",
        "choco install dotnet-7.0-sdk -y",
        "choco install openjdk -y",
        "choco install jenkins -y",
        "choco install git -y",
        "$env:PATH += ';C:\\Program Files\\dotnet'"
    ]
  }

  post-processor "vagrant" {}
  post-processor "compress" {}

}