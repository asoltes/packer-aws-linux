## Packer for AWS with ansible user

create a `aws-key.json` file with the aws access key:

`touch aws-key.json`

```.json
{
    "aws_access_key": "",
    "aws_secret_key": ""
}
```
execute the following command to create the ami.

`packer build -var-file aws-key.json ubuntu_base.json`

## Sample Output


```
amazon-ebs: > Installing docker-compose ...
==> amazon-ebs:   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
==> amazon-ebs:                                  Dload  Upload   Total   Spent    Left  Speed
==> amazon-ebs: 100   633  100   633    0     0  24346      0 --:--:-- --:--:-- --:--:-- 24346
==> amazon-ebs: 100 12.1M  100 12.1M    0     0  14.4M      0 --:--:-- --:--:-- --:--:-- 50.8M
    amazon-ebs: > Adding Ansible User ...
    amazon-ebs: ansible ALL=(ALL) NOPASSWD:ALL
    amazon-ebs: > Installing SSH Key Files ...
    amazon-ebs: usermod: no changes
==> amazon-ebs: Stopping the source instance...
    amazon-ebs: Stopping instance
==> amazon-ebs: Waiting for the instance to stop...
==> amazon-ebs: Creating AMI ubuntu20.04-linux-base-os from instance i-0a56497badbe3ab0b
    amazon-ebs: AMI: ami-038c0537e498bc28d
==> amazon-ebs: Waiting for AMI to become ready...
==> amazon-ebs: Terminating the source AWS instance...
==> amazon-ebs: Cleaning up any extra volumes...
==> amazon-ebs: No volumes to clean up, skipping
==> amazon-ebs: Deleting temporary security group...
==> amazon-ebs: Deleting temporary keypair...
Build 'amazon-ebs' finished after 9 minutes 48 seconds.

==> Wait completed after 9 minutes 48 seconds

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
ap-southeast-1: ami-038c0537e498bc28d
```