# Terraform Tutorial

###### tags: `Terraform`

## Table of Contents
[TOC]
## Frequently Used Links
* [**Terraform: tfenv tool**](https://github.com/tfutils/tfenv)
* [**Terraform**](https://www.terraform.io/)
* [**AWS: Senao-Playground**](https://senao-playground.signin.aws.amazon.com/console)
* [**Terraform Instruction Video**](https://www.youtube.com/watch?v=iRaai1IBlB0&t=135s&ab_channel=freeCodeCamp.org)
## Environment Setup   
:::info
:bulb: **Specified Version**
* For lab and staging: version <font color= red> 0.12.30 </font> 
* For production: version <font color= red> 0.11.14 </font>
:::
### MAC
- [ ] Step 1: go to  [**Terraform: tfenv tool**](https://github.com/tfutils/tfenv) and follow th instructions to install tfenv tool, the following use the MAC OS as the example.
```
peterli------- % brew install tfenv
-----
peterli------- % tfenv help ---> check whether the tfenv is available.
```
- [ ] Step 2: Use `tfenv install VERSION` to install the designated version.
```
peterli..... ~ % tfenv install 0.12.30
.....
peterli..... ~ % tfenv install 0.11.14
.....
peterli..... ~ % tfenv list -----> check the installed list 
  0.12.30
  0.11.14
No default set. Set with 'tfenv use <version>'
```
- [ ] Step 3: Use the specified installled version by `tfenv use VERSION`
```
peterli...~ % tfenv use 0.11.14
Switching default version to v0.11.14
Switching completed
....
peterli... ~ % terraform version --> check the version 
Terraform v0.11.14
```
### Ubuntu/ Debian
 - [ ] Step 1: Clone the repo of https://github.com/tfutils/tfenv by `git clone https://github.com/tfutils/tfenv.git ~/.tfenv`
 - [ ] Step 2: Create the symlink to the `/usr/local/bin` by `sudo ln -s ~/.tfenv/bin/* /usr/local/bin`
> The PATH of Linux generally lies in  `etc/environment` which can be displayed by `echo $PATH`
```
admin@-----:~$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
```
- [ ] Step 3: Use `which tfenv` and `tfenv` to check `tfenv` is successfully installed.
```
admin@-----:~$ which tfenv
/usr/local/bin/tfenv
admin@-----:~$ tfenv
tfenv 2.2.3
Usage: tfenv <command> [<options>]

Commands:
   install       Install a specific version of Terraform
   use           Switch a version to use
   uninstall     Uninstall a specific version of Terraform
   list          List all installed versions
   list-remote   List all installable versions
   version-name  Print current version
   init          Update environment to use tfenv correctly.
   pin           Write the current active version to ./.terraform-versio
```
- [ ] Step 4: Use `tfenv install VERSION` to install the designated version.
```
admin@-----:~$  tfenv install 0.12.30
.....
admin@-----:~$  tfenv install 0.11.14
.....
admin@-----:~$  tfenv list -----> check the installed list 
  0.12.30
  0.11.14
No default set. Set with 'tfenv use <version>'
```
- [ ] Step 5: Use the specified installled version by `tfenv use VERSION`
```
admin@-----:~$ tfenv use 0.11.14
Switching default version to v0.11.14
Switching completed
```
- [ ] Step 6: Check the version by `terraform version` or `tfenv list`
```
admin@-----:~$ terraform version --> check the version 
Terraform v0.11.14
```
```
admin@TenacityAWS:~$ tfenv list
  0.12.30
* 0.11.14 (set by /home/admin/.tfenv/version) ---> current version
```
### Retrieve Access key ID and Secret Key from AWS IAM
- [ ] Step 1: Go to [**AWS: Senao-Playground**](https://senao-playground.signin.aws.amazon.com/console) and Type `IAM` on the search bar and go into `IAM`.
![](https://i.imgur.com/xyJnIEO.png)
- [ ] Step 2: On the Left bar, choose **Users** adn click on your name, then go to the **Security credentials**.
![](https://i.imgur.com/tXObuiB.png)
- [ ] Step 3: Press **Create access key**, and download the **CSV file which contains the Key ID and Secrte Key number that YOU MUST NOT REVEAL to the public.** 
![](https://i.imgur.com/JlhlDxF.png)
![](https://i.imgur.com/ueCJ5W7.png)
> It is important to know that only **2** accsess keys can be retrieved from AWS IAM. If you lost 2 keys already, plaese make inactive the old keys here, and create new one. 
## Hands-on Practice
:::success 
:man-tipping-hand: **About AWS Provider Version**
* In this memo, after `terraform init`, the AWS provider version is [**<font color= red>3.37</font>**](https://registry.terraform.io/providers/hashicorp/aws/3.37.0/docs) :arrow_left: (click on the version to know how to set up the code for aws resources). 
:::
### Terraform Initialize
- [ ] Step 1: make sure that `aws-cli` is installed: 
    * MAC: `sudo brew install awscli`
    * Ubuntu/Debian: `sudo apt-get install awscli`
    * For the lastest version: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html 
- [ ] Step 2: use `aws configure` to put into the Access key ID and Secret Key that is retrieved from AWS IAM.
```
ubuntu@----------:~/.aws$ aws configure
AWS Access Key ID:
AWS Secret Access Key:
Default region name:
```
> use `aws s3 ls` or `aws ec2 describe-instances` to check whether configuration is successful. If successful, the current s3 and ec2 resources will be provided.
- [ ] Step 3: `cd ~/.aws` and `vim credentials` to rename the profile
```
# name the profile in the bracket
[peter-test] ----> profile
aws_access_key_id = xxxxxxxxx
aws_secret_access_key = XXXXXXXXXX
``` 
- [ ] Step 4: Set up the `provider.tf` to make terrafrom know which cloud provider it should connect.
    * [**Link for the format of `provider.tf`**](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#:~:text=Terraform%200.12%20and%20earlier%3A) 
    * use `vim provider.tf` to set up the provider profile. In the profile, the key is provided in other place, which is mentioned.
    * For the saftey concern, the key shoudld be offered in the [**`shared_credentials_files` format**](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-configuration-and-credentials-files). 
    * The profile is the name as described in the `~/.aws/credentials`.
> In this step, the version `version = "~> xxxx"` isn't needed to be specified in the `provider.tf`. 
```
ubuntu@----:~/terraformtutorial$ cat provider.tf
provider "aws" {
  region                  = "us-west-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "peter-test"
}
```
- [ ] Step 5: use `terraform init` to initialize the connection b/t terraform and aws.
```
ubuntu@------:~/terraformtutorial$ terraform init

Initializing the backend...

Initializing provider plugins...

...

* provider.aws: version = "~> 3.37"  ----------> provider version

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
- [ ] Step 6: Check whether `version 3.37` is downloaded.

```
ubuntu@----:~/terraformtutorial/.terraform/plugins/linux_amd64$ ls
lock.json  terraform-provider-aws_v3.37.0_x5
```
### VPC
- [ ] Step 1: `vim vpc.tf`
```
# "aws_vpc": aws rescource vpc ----> name can't be changed
# "peter_terraform_vpc": the logical name of the VPC on terrafrom to make reference in the future, that won't be showed on AWS
resource "aws_vpc" "peter_terraform_vpc" {
# setting the private VPC range 
  cidr_block            = "10.87.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true


  tags = {
# naming VPC in AWS Console
    Name = "peter_vpc"
  }
}
```
- [ ] Step 2: Use`terraform plan` to preview what will be going to be built:
```
ubuntu@----------:~/terraformtutorial$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.peter_terraform_vpc will be created
  + resource "aws_vpc" "peter_terraform_vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.87.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "peter_vpc"
        }
      + tags_all                         = {
          + "Name" = "peter_vpc"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```
- [ ] Step 3: Use `terrafrom apply` to create VPC. If you are sure to deploy the VPC resource on AWS, type `yes` when the prompt shows `Enter a value:`
```
ubuntu@------:~/terraformtutorial$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.peter_terraform_vpc will be created
  + resource "aws_vpc" "peter_terraform_vpc" {
...

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes  ----------> type `yes` to create VPC

aws_vpc.peter_terraform_vpc: Creating...
aws_vpc.peter_terraform_vpc: Still creating... [10s elapsed]
aws_vpc.peter_terraform_vpc: Creation complete after 12s [id=vpc-0ea26dbaeb9c2ac8f] ----> VPC ID is here
```
- [ ] Step 4: check the resources on AWS console
![](https://i.imgur.com/oqtZAPm.png)

### Check the State
:::warning
:label: **MUST READ**
* This [**<font color= red> link </font>**](https://www.terraform.io/language/state) shows how terraform connects with AWS.
:::

- [ ] Terraform must **store state about your managed infrastructure and configuration.** 
- [ ] This state is stored by default in a local file named `terraform.tfstate`:
```
ubuntu@------:~/terraformtutorial$ ls
provider.tf  terraform.tfstate  vpc.tf
```
- [ ] Direct file editing of the `terraform.tfstate` is discouraged. Terraform provides the `terraform state` command to perform basic modifications of the state using the CLI.
```
ubuntu@------:~/terraformtutorial$ terraform state list
aws_vpc.peter_terraform_vpc ---> VPC instance 
```
- [ ] Use `terraform state show aws_vpc.peter_terraform_vpc` to see the full info of `aws_vpc.peter_terraform_vpc` 
```
ubuntu@---------:~/terraformtutorial$ terraform state show aws_vpc.peter_terraform_vpc
# aws_vpc.peter_terraform_vpc:
resource "aws_vpc" "peter_terraform_vpc" {
    arn                              = "arn:aws:ec2:us-west-1:205943798376:vpc/vpc-015e00a2f2442a50d"
    assign_generated_ipv6_cidr_block = false
    cidr_block                       = "10.87.0.0/16"
    default_network_acl_id           = "acl-0469e05c5662dd155"
    default_route_table_id           = "rtb-09b4eb2ae103e8c42"
    default_security_group_id        = "sg-036a70ce99681013e"
    dhcp_options_id                  = "dopt-0a86732bf370bbeeb"
    enable_classiclink               = false
    enable_classiclink_dns_support   = false
    enable_dns_hostnames             = true
    enable_dns_support               = true
    id                               = "vpc-015e00a2f2442a50d"
    instance_tenancy                 = "default"
    main_route_table_id              = "rtb-09b4eb2ae103e8c42"
    owner_id                         = "XxXXXXXXXXXX"
    tags                             = {
        "Name" = "peter_vpc"
    }
    tags_all                         = {
        "Name" = "peter_vpc"
    }
}
```
- [ ] Use `terrafrom show` to see the full detail of all the instances
```
ubuntu@------:~/terraformtutorial$ terraform show
# aws_vpc.peter_terraform_vpc:
resource "aws_vpc" "peter_terraform_vpc" {
    arn                              = "arn:aws:ec2:us-west-1:205943798376:vpc/vpc-015e00a2f2442a50d"
    assign_generated_ipv6_cidr_block = false
    cidr_block                       = "10.87.0.0/16"
    default_network_acl_id           = "acl-0469e05c5662dd155"
    default_route_table_id           = "rtb-09b4eb2ae103e8c42"
    default_security_group_id        = "sg-036a70ce99681013e"
    dhcp_options_id                  = "dopt-0a86732bf370bbeeb"
    enable_classiclink               = false
    enable_classiclink_dns_support   = false
    enable_dns_hostnames             = true
    enable_dns_support               = true
    id                               = "vpc-015e00a2f2442a50d"
    instance_tenancy                 = "default"
    main_route_table_id              = "rtb-09b4eb2ae103e8c42"
    owner_id                         = "XXXXXXXXXXXXX"
    tags                             = {
        "Name" = "peter_vpc"
    }
    tags_all                         = {
        "Name" = "peter_vpc"
    }
}
```
### Destroy 
:::warning
:mailbox: **Attentions!**
* Be careful to use `terrafrom destroy`.
* [**<font color= red> Instruction 1 </font>**](https://www.terraform.io/cli/commands/destroy)
* [**<font color= red> Instruction 2 </font>**](https://spacelift.io/blog/how-to-destroy-terraform-resources)
:::
- [ ] To mock what will be going on if we want to destroy `aws_vpc.peter_terraform`: `terraform plan -destroy --target aws_vpc.peter_terraform`
```
ubuntu@--------:~/terraformtutorial$ terraform plan -destroy --target aws_vpc.peter_terraform
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_vpc.peter_terraform: Refreshing state... [id=vpc-06e3286967d3a6822]

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_vpc.peter_terraform will be destroyed
  - resource "aws_vpc" "peter_terraform" {
      - arn                              = "arn:aws:ec2:us-west-1:205943798376:vpc/vpc-06e3286967d3a6822" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "10.87.0.0/16" -> null
      - default_network_acl_id           = "acl-02bf5731e9ae7553d" -> null
      - default_route_table_id           = "rtb-07f030e18e4692101" -> null
      - default_security_group_id        = "sg-0b98894605d816c13" -> null
      - dhcp_options_id                  = "dopt-0a86732bf370bbeeb" -> null
      - enable_classiclink               = false -> null
      - enable_classiclink_dns_support   = false -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-06e3286967d3a6822" -> null
      - instance_tenancy                 = "default" -> null
      - main_route_table_id              = "rtb-07f030e18e4692101" -> null
      - owner_id                         = "xxxxxxxxxxxxx" -> null
      - tags                             = {
          - "Name" = "peter"
        } -> null
      - tags_all                         = {
          - "Name" = "peter"
        } -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Warning: Resource targeting is in effect

You are creating a plan with the -target option, which means that the result
of this plan may not represent all of the changes requested by the current
configuration.

The -target option is not for routine use, and is provided only for
exceptional situations such as recovering from errors or mistakes, or when
Terraform specifically suggests to use it as part of an error message.


------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```
- [ ] To REALLY destroy `aws_vpc.peter_terraform`: `terraform destroy --target aws_vpc.peter_terraform`
```
ubuntu@---:~/terraformtutorial$ terraform destroy --target aws_vpc.peter_terraform
aws_vpc.peter_terraform: Refreshing state... [id=vpc-06e3286967d3a6822]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_vpc.peter_terraform will be destroyed
...
Plan: 0 to add, 0 to change, 1 to destroy.


Warning: Resource targeting is in effect

You are creating a plan with the -target option, which means that the result
of this plan may not represent all of the changes requested by the current
configuration.

The -target option is not for routine use, and is provided only for
exceptional situations such as recovering from errors or mistakes, or when
Terraform specifically suggests to use it as part of an error message.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes ---> type `YES` to destroy

aws_vpc.peter_terraform: Destroying... [id=vpc-06e3286967d3a6822]
aws_vpc.peter_terraform: Destruction complete after 0s
...
Destroy complete! Resources: 1 destroyed.
```
- [ ] Confirm with `terraform show`:
```
ubuntu@----:~/terraformtutorial$ terraform show
               ------> Nothing left
ubuntu@----:~/terraformtutorial$
```
- [ ] Use `terraform apply` to recreate and use `terraform state list` to see the status:
```
ubuntu@----:~/terraformtutorial$ terraform apply
...
aws_vpc.peter_terraform: Creating...
aws_vpc.peter_terraform: Still creating... [10s elapsed]
aws_vpc.peter_terraform: Creation complete after 11s [id=vpc-0182edca98dd3f693]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
ubuntu@---:~/terraformtutorial$ terraform state list
aws_vpc.peter_terraform
```
:::success
:round_pushpin: Flag `-auto-approve`
* `terraform apply -auto-approve` ---> **CREATE resources WITHOUT Confirm**
* `terraform destroy -auto-approve` ---> **DESTROY resources WITHOUT Confirm**
:::
### Subnet
:::info
:mage: **Definiton**
* [**<font color= red> Reference </font>**](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html#subnet-basics): A subnet is **a range of IP addresses in your VPC**. When you create a subnet, you specify the IPv4 CIDR block for the subnet, which is a subset of the VPC CIDR block. Each subnet must reside entirely within **one Availability Zone and cannot span zones**. 
* [**<font color= red> Format of subnet on Terrafrom </font>**](https://registry.terraform.io/providers/hashicorp/aws/3.37.0/docs/resources/subnet)
:::

- [ ] Step 1: Since `subnet` should reside in the `VPC`, use `terrafrom show` to track the `VPC` id and `cidr_block`:
```
# aws_vpc.peter_terraform_vpc: -----> VPC ID
resource "aws_vpc" "peter_terraform_vpc" {
...
    cidr_block                       = "10.87.0.0/16" ----> IPV4 CIDR block
```
- [ ] Step 2: vim `subnet.tf`, and do what follows:
```
# Create the subnet, naming resources subnet
# cidr_block of subnet should be smaller than vpc aws_vpc.peter_terraform_vpc range: 10.87.0.0/16
# map_public_ip_on_launch ---> Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
resource "aws_subnet" "peter_terraform_public_subnet" {
   vpc_id                  = aws_vpc.peter_terraform_vpc.id
   cidr_block              = "10.87.1.0/24"
   map_public_ip_on_launch = true
   availability_zone        = "us-west-1a"

# Naming the subnet on AWS console
   tags = {
     Name = "peter_public_subnet"
   }
}
```
> Use `aws ec2 describe-availability-zones --all-availability-zones` to make sure what zones are available, but the regions of VPC and subnet should be the SAME.

- [ ] Step 3: Use `terraform plan` to preview:
```
ubuntu@----:~/terraformtutorial$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_vpc.peter_terraform_vpc: Refreshing state... [id=vpc-015e00a2f2442a50d]

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_subnet.peter_terraform_public_subnet will be created
  + resource "aws_subnet" "peter_terraform_public_subnet" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-west-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.87.1.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "peter_public_subnet"
        }
      + tags_all                        = {
          + "Name" = "peter_public_subnet"
        }
      + vpc_id                          = "vpc-015e00a2f2442a50d"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```
- [ ] Step 4: Create the subnet by `terraform apply`
```
ubuntu@-----:~/terraformtutorial$ terraform apply
aws_vpc.peter_terraform_vpc: Refreshing state... [id=vpc-015e00a2f2442a50d]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_subnet.peter_terraform_public_subnet will be created
  + resource "aws_subnet" "peter_terraform_public_subnet" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-west-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.87.1.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "peter_public_subnet"
        }
      + tags_all                        = {
          + "Name" = "peter_public_subnet"
        }
      + vpc_id                          = "vpc-015e00a2f2442a50d"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes ---> type "YES" here

aws_subnet.peter_terraform_public_subnet: Creating...
aws_subnet.peter_terraform_public_subnet: Still creating... [10s elapsed]
aws_subnet.peter_terraform_public_subnet: Creation complete after 10s [id=subnet-0c9320265a689e3b8]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
- [ ] Step 5: Check the result both on AWS console and by `terraform show`.
![](https://i.imgur.com/cXEkXEZ.png)
```
ubuntu@-----:~/terraformtutorial$ terraform show
# aws_subnet.peter_terraform_public_subnet:
resource "aws_subnet" "peter_terraform_public_subnet" {
    arn                             = "arn:aws:ec2:us-west-1:205943798376:subnet/subnet-0c9320265a689e3b8"
    assign_ipv6_address_on_creation = false
    availability_zone               = "us-west-1a"
    availability_zone_id            = "usw1-az3"
    cidr_block                      = "10.87.1.0/24"
    id                              = "subnet-0c9320265a689e3b8"
    map_customer_owned_ip_on_launch = false
    map_public_ip_on_launch         = true
    owner_id                        = "205943798376"
    tags                            = {
        "Name" = "peter_public_subnet"
    }
    tags_all                        = {
        "Name" = "peter_public_subnet"
    }
    vpc_id                          = "vpc-015e00a2f2442a50d"
}
```
### Internet Gateway
:::success
:mag_right: **Differences b/t Internet and NAT Gateways**
* [<font color= red>**Internet Gateways**</font>](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html):An internet gateway enables resources (like EC2 instances) in your **public subnets to connect to the internet if the resource has a public IPv4 address or an IPv6 address.** Similarly, **resources on the internet can initiate a connection to resources in your subnet using the public IPv4 address or IPv6 address**.
* [<font color= red>**NAT Gateways**</font>](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html): A NAT gateway is a Network Address Translation (NAT) service. You can use a NAT gateway so that instances in a private subnet **can connect to services outside your VPC but external services cannot initiate a connection with those instances**.
:::
- [ ] Step 1: Use `terraform state list` to locate the name of the VPC
```
ubuntu@----:~/terraformtutorial$ terraform state list
aws_subnet.peter_terraform_public_subnet
aws_vpc.peter_terraform_vpc ---> VPC id NAME
```
- [ ] Step 2:`vim internetgateway.tf` to create the file:
```
ubuntu@-----:~/terraformtutorial$ vim internetgateway.tf
# Naming the internet gateway "aws_internet_gateway" "peter_terraform_internet_gateway"

resource "aws_internet_gateway" "peter_terraform_internet_gateway" {
  vpc_id = aws_vpc.peter_terraform_vpc.id

  tags = {
    Name = "peter_terraform_internet_gateway"
  }
}

```
:::info
:man-tipping-hand: **Tidy Up!**
* `terraform fmt` : the command will help tidy up the format of of the `.tf` file, the following are the files which are originally not in good format, and then are formatted well.
```
ubuntu@----:~/terraformtutorial$ terraform fmt
internetgateway.tf
subnet.tf
vpc.tf
```
:::

- [ ] Step 3: Use `terrafrom plan ` to have a great preview:
```
ubuntu@----:~/terraformtutorial$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_vpc.peter_terraform_vpc: Refreshing state... [id=vpc-015e00a2f2442a50d]
aws_subnet.peter_terraform_public_subnet: Refreshing state... [id=subnet-0c9320265a689e3b8]

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_internet_gateway.peter_terraform_internet_gateway will be created
  + resource "aws_internet_gateway" "peter_terraform_internet_gateway" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "peter_terraform_internet_gateway"
        }
      + vpc_id   = "vpc-015e00a2f2442a50d"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```
- [ ] Step 4: Use `terraform apply -auto-approve` to create the `internet_gateway` without typing `yes`:
```
ubuntu@----:~/terraformtutorial$ terraform apply -auto-approve
aws_vpc.peter_terraform_vpc: Refreshing state... [id=vpc-015e00a2f2442a50d]
aws_subnet.peter_terraform_public_subnet: Refreshing state... [id=subnet-0c9320265a689e3b8]
aws_internet_gateway.peter_terraform_internet_gateway: Creating...
aws_internet_gateway.peter_terraform_internet_gateway: Creation complete after 1s [id=igw-0bdba8452362a0648]
```
- [ ] Step 5: Check on AWS console
![](https://i.imgur.com/MEKqCK4.png)
### Routing 




