# Initial setup

Install Ansible + Terraform + dynamic inventory

```
git clone https://github.com/pescobar/terraform-ansible-tests.git ~/terraform-ansible-tests
bash ~/terraform-ansible-tests/install.sh
export PATH=~/.terraform-ansible-tests/bin:$PATH
```

# Slurm PoC

[slurm-example](slurm-example) is modified version of the [official OpenStack example](https://github.com/terraform-providers/terraform-provider-openstack/tree/master/examples/app-with-networking)

The small modifications are in [main.tf starting at line 61](slurm-example/main.tf#L61)


## configuration

Define the [proper environment variables](https://docs.openstack.org/zh_CN/user-guide/common/cli-set-environment-variables-using-openstack-rc.html) to access your OpenStack cloud. You can find and example in [slurm-example/openrc.sample](slurm-example/openrc.sample). 

Edit [~/terraform-ansible-tests/slurm-example/variables.tf](slurm-example/variables.tf) with the right values for your setup. You can
query your `external_gateway` value running `openstack network list --external`

```
$ openstack network list --external
+--------------------------------------+--------+----------------------------------------------------------------------------+
| ID                                   | Name   | Subnets                                                                    |
+--------------------------------------+--------+----------------------------------------------------------------------------+
| 3cc83f7d-9119-475b-ba17-f3510c7902e8 | public | a2d7c467-44f9-43c5-b387-8a6742f45b5c, ee51200c-9b64-4977-ad30-622039d7bba1 |
+--------------------------------------+--------+----------------------------------------------------------------------------+
```

Some other useful commands to fill-up `variables.tf`

```
openstack image list
openstack flavor list
```

Create a ssh key

```
ssh-keygen -N '' -f ~/.ssh/id_rsa_terraform
```


## boot the VMs and create all the resources in OpenStack (networks, security groups..etc)

```
cd ~/terraform-ansible-tests/slurm-example
terraform init
terraform plan
terraform apply -auto-approve
```

## Test the dynamic inventory

```
cd ~/terraform-ansible-tests/slurm-example

ansible -i ~/.terraform-ansible-tests/bin/terraform.py all -m ping --list-hosts
ansible -i ~/.terraform-ansible-tests/bin/terraform.py os_metadata_slurm_worker=True -m ping --list-hosts
ansible -i ~/.terraform-ansible-tests/bin/terraform.py os_metadata_slurm_master=True -m ping --list-hosts

terraform.py --list --pretty --root ~/terraform-ansible-tests/slurm-example/
terraform.py --hostfile --root ~/terraform-ansible-tests/slurm-example/
terraform.py --host slurm_master --pretty --root ~/terraform-ansible-tests/slurm-example/

openstack server list
openstack network list
openstack security group list
openstack keypair list

```

## Stop the VMs and destroy all the resources
```
cd ~/terraform-ansible-tests/slurm-example
terraform destroy -force

openstack server list
openstack network list
openstack security group list
openstack keypair list
```

