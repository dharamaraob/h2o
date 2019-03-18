1. Prerequisites: Terraform need to be installed.<br/>
2. Account Id must be updated with the respective account.<br/>
3. Here I am using IAM Role. Either IAM Role(Recommended) need to be created or should use the AWS keys for this demo (Not a best practice)<br/>
I am creating a vpc with the below resources<br/>
    1. Public Subnet<br/>
    1. Private Subnet<br/>
    1. IG<br/>
    1. Nat Gateway<br/>
    2. Route tables and their associations<br/>
    1. Security Group for each public and private subnet.<br/>

Note:<br/>
    1. Please add the instance ip address cidr in public sg for 22(SSH) and 54321(to Access the application)<br/>
    2. Add your SSH keys, I am not uploading the keys here.<br/>

Ex:<br/>
ubuntu@ip-20-200-1-123:/tmp/tf/4/h2o$ python h2otf.py --cmd init<br/>
    Run this command to initialize for the first time.<br/>

Ex: Run the plan and to save the plan in the file named ins, run : $ python h2otf.py --cmd plan<br/>
ubuntu@ip-20-200-1-123:/tmp/tf/4/h2o$ python h2otf.py --cmd plan<br/>
Plan<br/>
Refreshing Terraform state in-memory prior to plan...<br/>
The refreshed state will be used to calculate this plan, but will not be<br/>
persisted to local or remote state storage.<br/>


Ex:<br/>
If you are satisfied with your changes, to apply the infra<br/>
ubuntu@ip-20-200-1-123:/tmp/tf/4/h2o$ python h2otf.py --cmd apply<br/>
apply<br/>
aws_eip.Admin-nat-eip: Creating...<br/>
  allocation_id:     "" => "<computed>"<br/>
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
  :<br/>
  :<br/>
  aws_instance.jump (remote-exec): nohup: appending output to ‘nohup.out’<br/>
aws_instance.jump: Creation complete after 4m44s (ID: i-02b01509101874f86)<br/>
<br/>
Apply complete! Resources: 15 added, 0 changed, 0 destroyed.<br/>
<br/>
Outputs:<br/>

private_dns.jump  = ip-172-22-1-120.us-west-2.compute.internal<br/>
public_ip.jump = 54.245.184.32<br/>
ubuntu@ip-20-200-1-123:/tmp/tf/4/h2o$<br/>

Ex: $python h2otf.py --cmd destroy<br/>
:
Plan: 0 to add, 0 to change, 15 to destroy.<br/>

Do you really want to destroy all resources?<br/>
  Terraform will destroy all your managed infrastructure, as shown above.<br/>
  There is no undo. Only 'yes' will be accepted to confirm.<br/>
  Enter a value: yes<br/>
  :<br/>
  Destroy complete! Resources: 15 destroyed.<br/>

to browse H2o3 application<br/>

http://54.245.184.32:54321<br/>

Further Improvements:<br/>
1. Create a ELB and put infront of the Instance.<br/>
2. Create a Route53 and add the ELB to Route53 and browse the application using Route53 ex: h2o3-opensrc.h2o.com<br/>
3. Instead of creating the instance in Public Subnet , create it in private subnet and create the ELB aswell in private subnet.<br/>
4. Modules and Environments can be incorporated.<br/>
