1. Prerequisites: Terraform need to be installed.
2. Account Id must be updated with the respective account.
3. Here I am using IAM Role. Either IAM Role(Recommended) need to be created or should use the AWS keys for this demo (Not a best practice)
I am creating a vpc with the below resources
    1. Public Subnet
    1. Private Subnet
    1. IG
    1. Nat Gateway
    2. Route tables and their associations
    1. Security Group for each public and private subnet.

Note:
    1. Please add the instance ip address cidr in public sg for 22(SSH) and 54321(to Access the application)
    2. Add your SSH keys, I am not uploading the keys here.

Ex:
ubuntu@ip-20-200-1-123:/tmp/tf/4/h2o$ python h2otf.py --cmd init
    Run this command to initialize for the first time.

Ex: Run the plan and to save the plan in the file named ins, run : $ python h2otf.py --cmd plan
ubuntu@ip-20-200-1-123:/tmp/tf/4/h2o$ python h2otf.py --cmd plan
Plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


Ex:
If you are satisfied with your changes, to apply the infra
ubuntu@ip-20-200-1-123:/tmp/tf/4/h2o$ python h2otf.py --cmd apply
apply
aws_eip.Admin-nat-eip: Creating...
  allocation_id:     "" => "<computed>"
  association_id:    "" => "<computed>"
  domain:            "" => "<computed>"
  instance:          "" => "<computed>"
  network_interface: "" => "<computed>"
  private_dns:       "" => "<computed>"
  private_ip:        "" => "<computed>"
  public_dns:        "" => "<computed>"
  public_ip:         "" => "<computed>"
  public_ipv4_pool:  "" => "<computed>"
  vpc:               "" => "true"
  :
  :
  aws_instance.jump (remote-exec): nohup: appending output to ‘nohup.out’
aws_instance.jump: Creation complete after 4m44s (ID: i-02b01509101874f86)

Apply complete! Resources: 15 added, 0 changed, 0 destroyed.

Outputs:

private_dns.jump  = ip-172-22-1-120.us-west-2.compute.internal
public_ip.jump = 54.245.184.32
ubuntu@ip-20-200-1-123:/tmp/tf/4/h2o$

Ex: $python h2otf.py --cmd destroy
:
Plan: 0 to add, 0 to change, 15 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.
  Enter a value: yes
  :
  Destroy complete! Resources: 15 destroyed.

to browse H2o3 application

http://54.245.184.32:54321

Further Improvements:
1. Create a ELB and put infront of the Instance.
2. Create a Route53 and add the ELB to Route53 and browse the application using Route53 ex: h2o3-opensrc.h2o.com
3. Instead of creating the instance in Public Subnet , create it in private subnet and create the ELB aswell in private subnet.
4. Modules and Environments can be incorporated.