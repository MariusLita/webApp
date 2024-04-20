Hello in order to run this application you will have to follow the next steps.

- clone this repo.
- change directory to the prerequisites folder.
- Have packer installed on your current OS.
- Run packer init . 
- Run packer validate .
- Run packer build prerequisites.pkr.hcl

The custom image will be stored in the AWS, you will have to edit the access_key and secret_key with your AWS credentials in order to work and also choose a source_ami ( if this one do not work )
After the prerequisite custom image will be done you will need to change current directory to application directory.
Edit the application.pkr.hcl with the previous prerequisite ami id and the same access and secret key.
Run again packer init . / packer validate . / packer build application.pkr.hcl

At this point you will have a custom image with the application installed. You can use this ami to create VM in AWS.

If you want to run the application on your device
You will have to have dotnet SDK 7.0 installed.
On windows you can install with chocolatey and after that just run 
	choco install dotnet-7.0-sdk 

Switch directory to application dirrectory and run:
	dotnet build
	dotnet run

In order to test if the application works you can access:
	http://localhost:5201

You should see a message "Hello Wolrd" which means the application runs succesfully.
