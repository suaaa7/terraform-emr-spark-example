# Spark on Amazon EMR + Terraform 
An example Terraform project that will configure a Secure and Customizable 
Spark Cluster on Amazon EMR.  Zeppelin is also installed as an interface to 
Spark, and Ganglia is also installed for monitoring.

## Building

```
# this will build all of the modules
terraform init

# this will provide detail on what Terraform will change
terraform plan -var 'vpc_id=vpc-498ad52c' -var 'cluster_name=cnusstest1' 

# this will actually make the change
terraform apply -var 'vpc_id=vpc-498ad52c' -var 'cluster_name=cnusstest1'
```

## FAQs

### I've changed something in `bootstrap`, why didn't that get applied?
TODO

### I want this to run in another region, what do I do?
TODO

### How do I SSH into this cluster?
TODO
 - SSH Key in generated/

### The state file is saved locally, how do I share that with others?
TODO

## Variables

### Master CIDR Blocks
TODO: Explain how to get the EMR CIDR blocks from Amazon.
https://forums.aws.amazon.com/ann.jspa?annID=2347

# TODO
[] mention tainting the cluster to force a rebuild
[] mention Zeppelin auth for users
[] mention trusted networks
[] search for cchh anywhere and remove
[] how to connect
[] sec module assumptions
[] note that notebooks are saved in S3
[] PSA about subnet ID lookups
[] comments in IAM about policies
