This is modified version of the [official OpenStack example](https://github.com/terraform-providers/terraform-provider-openstack/tree/master/examples/app-with-networking)

Edit [variables.tf](variables.tf) with the right values for your setup. You can
query your `external_gateway` value running `openstack network list --external`

```
$ openstack network list --external
+--------------------------------------+--------+----------------------------------------------------------------------------+
| ID                                   | Name   | Subnets                                                                    |
+--------------------------------------+--------+----------------------------------------------------------------------------+
| fd21df30-693b-496a-ac69-8637b9c24cd3 | public | a2d7c467-44f9-43c5-b387-8a6742f45b5c, ee51200c-9b64-4977-ad30-622039d7bba1 |
+--------------------------------------+--------+----------------------------------------------------------------------------+
```


