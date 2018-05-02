# Initial setup

Install Ansible + Terraform + dynamic inventory by executing [install.sh](install.sh)

# Slurm PoC

[slurm-example](slurm-example) is modified version of the [official OpenStack example](https://github.com/terraform-providers/terraform-provider-openstack/tree/master/examples/app-with-networking)


## configuration

Edit [slurm-example/variables.tf](slurm-example/variables.tf) with the right values for your setup. You can
query your `external_gateway` value running `openstack network list --external`

```
$ openstack network list --external
+--------------------------------------+--------+----------------------------------------------------------------------------+
| ID                                   | Name   | Subnets                                                                    |
+--------------------------------------+--------+----------------------------------------------------------------------------+
| fd21df30-693b-496a-ac69-8637b9c24cd3 | public | a2d7c467-44f9-43c5-b387-8a6742f45b5c, ee51200c-9b64-4977-ad30-622039d7bba1 |
+--------------------------------------+--------+----------------------------------------------------------------------------+
```

## boot the VMs and create all the resources in OpenStack (networks, security groups..etc)

```
cd ~/terraform-ansible-tests/slurm-example
terraform init
terraform apply -auto-approve
```

## Test the dynamic inventory

```
ansible -i ~/terraform-ansible-tests/bin/terraform.py -m ping --list-hosts
ansible -i ~/bin/terraform.py os_metadata_slurm_worker=True -m ping --list-hosts

terraform.py --list --pretty --root ~/terraform-ansible-tests/slurm-example/
terraform.py --hostfile
terraform.py --host slurm_master --pretty --root ~/terraform-ansible-tests/slurm-example/

openstack server list
openstack network list
openstack security group list
openstack keypair list

```

## Stop the VMs and destroy all the resources
```
terraform destroy -force

openstack server list
openstack network list
openstack security group list
openstack keypair list
```

