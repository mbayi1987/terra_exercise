Terraform Exercise
===

Please reproduce the following:

- Write a module in terraform, that will

    - use the AWS provider
    - provision an EC2 instance
    - install Docker
    - run the nginx Docker image
    - output the internal IP

- Then use that module in another terraform script

- Create a readme file

- In the readme file, comment on if you were to iterate on this, what would you add? Why? 

- Save to a github repo and send the link to the code for review


COMMENT
Install awscli to enable login /authentication
Install terraform to run the code.
Configure remote access to aws using <aws configure> from your command promt 
Fork repos to your work space.
Generate a privitae key using <ssh-keygen> to reside in your ~/.ssh/ directory
Run terraform init
    terraform validate
    terraform plan
    terraform appy
ssh with the output ip address to the EC2-instance
Test some docker commands as root (docker ps, docker images,...)
Do not forget to destroy instance using <terraform destroy>
