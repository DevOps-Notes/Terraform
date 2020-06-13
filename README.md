# Terraform

* Use Infrastructure as Code to provision and manage any cloud, infrastructure, or service
* Azure、AWS、Alibaba Cloud、Huawei Cloud、OpenStack, all supported at https://www.terraform.io/docs/providers/

```sh
# Install terraform
yum -y install unzip lrasz
wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
unzip terraform_0.12.26_linux_amd64.zip
mv terraform /usr/local/bin/
terraform

# Create a HDInsight Spark Cluster
vim HDInsight_Spark_Cluster.tf
terraform init
terraform apply

# Delete the Cluster
terraform destroy
```

