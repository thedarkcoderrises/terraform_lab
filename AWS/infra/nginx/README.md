# Here we are going to run Nginx in a docker container on ec2 instance using Terraform

To execute docker commands on remote host we need to open tcp port, in our case tcp://{aws.instance.publicIp}:1234/
Run a socat container to redirect the Docker API exposed on the unix domain socket in Linux to the port of your choice on your OS host:
docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:1234:1234 bobrik/socat TCP-LISTEN:1234,fork UNIX-CONNECT:/var/run/docker.sock

# Commands :
# Initialization
```
Abhijeets-MacBook-Pro:nginx javabrain$ terraform init

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.47.0...
- Downloading plugin for provider "docker" (terraform-providers/docker) 2.6.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.47"
* provider.docker: version = "~> 2.6"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

# Import existing EC2
```
Abhijeets-MacBook-Pro:nginx javabrain$ terraform import aws_instance.JB-TDCR-EC2-T2-MED-30G i-0b84ea6f7e41ef2d9
aws_instance.JB-TDCR-EC2-T2-MED-30G: Importing from ID "i-0b84ea6f7e41ef2d9"...
aws_instance.JB-TDCR-EC2-T2-MED-30G: Import prepared!
  Prepared aws_instance for import
aws_instance.JB-TDCR-EC2-T2-MED-30G: Refreshing state... [id=i-0b84ea6f7e41ef2d9]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.


Warning: Interpolation-only expressions are deprecated

  on nginx_aws.tf line 24, in resource "docker_container" "nginx":
  24:   image = "${docker_image.nginx.latest}"

Terraform 0.11 and earlier required all non-constant expressions to be
provided via interpolation syntax, but this pattern is now deprecated. To
silence this warning, remove the "${ sequence from the start and the }"
sequence from the end of this expression, leaving just the inner expression.

Template interpolation syntax is still used to construct strings from
expressions when the template includes multiple interpolation sequences or a
mixture of literal strings and interpolations. This deprecation applies only
to templates that consist entirely of a single interpolation sequence.

(and one more similar warning elsewhere)

```

# Plan 
```
Abhijeets-MacBook-Pro:nginx javabrain$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_instance.JB-TDCR-EC2-T2-MED-30G: Refreshing state... [id=i-0b84ea6f7e41ef2d9]

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach           = false
      + bridge           = (known after apply)
      + container_logs   = (known after apply)
      + exit_code        = (known after apply)
      + gateway          = (known after apply)
      + id               = (known after apply)
      + image            = (known after apply)
      + ip_address       = (known after apply)
      + ip_prefix_length = (known after apply)
      + log_driver       = "json-file"
      + logs             = false
      + must_run         = true
      + name             = "nginx"
      + network_data     = (known after apply)
      + read_only        = false
      + restart          = "no"
      + rm               = false
      + start            = true

      + ports {
          + external = 8080
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id     = (known after apply)
      + latest = (known after apply)
      + name   = "nginx:latest"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Warning: Interpolation-only expressions are deprecated

  on nginx_aws.tf line 24, in resource "docker_container" "nginx":
  24:   image = "${docker_image.nginx.latest}"

Terraform 0.11 and earlier required all non-constant expressions to be
provided via interpolation syntax, but this pattern is now deprecated. To
silence this warning, remove the "${ sequence from the start and the }"
sequence from the end of this expression, leaving just the inner expression.

Template interpolation syntax is still used to construct strings from
expressions when the template includes multiple interpolation sequences or a
mixture of literal strings and interpolations. This deprecation applies only
to templates that consist entirely of a single interpolation sequence.


------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

# Apply
```
Abhijeets-MacBook-Pro:nginx javabrain$ terraform apply
aws_instance.JB-TDCR-EC2-T2-MED-30G: Refreshing state... [id=i-0b84ea6f7e41ef2d9]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach           = false
      + bridge           = (known after apply)
      + container_logs   = (known after apply)
      + exit_code        = (known after apply)
      + gateway          = (known after apply)
      + id               = (known after apply)
      + image            = (known after apply)
      + ip_address       = (known after apply)
      + ip_prefix_length = (known after apply)
      + log_driver       = "json-file"
      + logs             = false
      + must_run         = true
      + name             = "nginx"
      + network_data     = (known after apply)
      + read_only        = false
      + restart          = "no"
      + rm               = false
      + start            = true

      + ports {
          + external = 8080
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id     = (known after apply)
      + latest = (known after apply)
      + name   = "nginx:latest"
    }

Plan: 2 to add, 0 to change, 0 to destroy.


Warning: Interpolation-only expressions are deprecated

  on nginx_aws.tf line 24, in resource "docker_container" "nginx":
  24:   image = "${docker_image.nginx.latest}"

Terraform 0.11 and earlier required all non-constant expressions to be
provided via interpolation syntax, but this pattern is now deprecated. To
silence this warning, remove the "${ sequence from the start and the }"
sequence from the end of this expression, leaving just the inner expression.

Template interpolation syntax is still used to construct strings from
expressions when the template includes multiple interpolation sequences or a
mixture of literal strings and interpolations. This deprecation applies only
to templates that consist entirely of a single interpolation sequence.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_image.nginx: Creating...
docker_image.nginx: Creation complete after 0s [id=sha256:881bd08c0b08234bd19136957f15e4301097f4646c1e700f7fea26e41fc40069nginx:latest]
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=1a505e2d76e51378d2f7c3cb83c3c545947fedfbcd64ef25520704b9b047bd37]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
Abhijeets-MacBook-Pro:nginx javabrain$ 
```


# Result
```
[root@ip-192-168-10-240 ec2-user]# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
1a505e2d76e5        881bd08c0b08        "nginx -g 'daemon of…"   2 minutes ago       Up 2 minutes        0.0.0.0:8080->80/tcp     nginx
cdbefc3de633        bobrik/socat        "socat TCP-LISTEN:12…"   3 hours ago         Up 3 minutes        0.0.0.0:1234->1234/tcp   tender_poitras
[root@ip-192-168-10-240 ec2-user]# 
Broadcast message from root@ip-192-168-10-240
	(unknown) at 18:30 ...

```
