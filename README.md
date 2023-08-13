# Creating the EKS cluster with the Terraform code.

You will be creating the EKS cluster with a user profile (default) that should 
have adequate permissions to create the cluster. As part of the cluster creation
the Terraform code also create an IAM user called <b>user1</b>. This user is the 
user under which you will be administering the cluster with the kubectl tool.

So, first check that your AWSCLI is configured with the default profile that 
has the permissions to create the cluster. (~/.aws/credentials)

```
[default]
aws_access_key_id = AKIA------------37L44
aws_secret_access_key = QVgNZ2------------q8LnI1NzmM
```

If you are happy that the user whose keys are in the ~/.aws/credentials has the permissions, 
proceed with creating the EKS cluster with Terraform. Change to the terraform directory and run the following commands to create the cluster.
```
terraform init
terraform plan
terraform apply
```
### Configure the user1 profile on the AWSCLI

Log onto the AWS account where the EKS cluster has been created and navigate to IAM.
Locate the user1 user and proceed to create its AWS access key and secrets and copy them.

The run the following command to configure the AWSCLI for the user1 user
```
aws configure --profile user1
```

Upon completion of the profile the ~/.aws/credentials should look something like this;
```
[default]
aws_access_key_id = AKIA------------37L44
aws_secret_access_key = QVgNZ2------------q8LnI1NzmM
[user1]
aws_access_key_id = AKIA----------Z457L44
aws_secret_access_key = QWgNZ2H9x-----------8LnI1NzWM
```


Now, configure role assumption so that the user1 can assume the role eks-admin.
Edit the ~/.aws/config file as follows. Replace the placeholder ?????????????? with your AWS account number.
```
[profile eks-admin]
role_arn = arn:aws:iam::??????????????:role/eks-admin
source_profile = user1
```

Check that you can now assume the role with the following command.
```
aws sts get-caller-identity --profile eks-admin
```
You should see something like this.
```
{
    "UserId": "AROA3KDCOZFY2POBFNH25:botocore-session-1691075771",
    "Account": "?????????????",
    "Arn": "arn:aws:sts::?????????????:assumed-role/eks-admin/botocore-session-1691075771"
}
```
(If you have not yet installed the kubectl tool, go ahead and install it)
Check the location of the kubectl config file 
```
ls -l ~/.kube/
```

Update the cluster kube config file with the following command.
```
aws eks update-kubeconfig --name techoutcomes --region eu-west-1 --profile eks-admin 
```
(The above command will retrieve the clusters credentials and save them in the ~/.kube/config file)

Connect to the cluster and check that you can get the nodes and pods details
```
kubectl get nodes
kubectl get pods
```



### Deploy application - game2048 application
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/examples/2048/2048_full.yaml

kubectl get pods -A

```

### Get load balancer details
```
kubectl get ingress/ingress-2048 -n game-2048
```

You should see something like
```
NAME           CLASS   HOSTS   ADDRESS                                                                  PORTS   AGE
ingress-2048   alb     *       k8s-game2048-ingress2-4236167aae-782965586.us-east-1.elb.amazonaws.com   80      16s
```


Browse to the application with the URL 
```
http://k8s-game2048-ingress2-4236167aae-782965586.us-east-1.elb.amazonaws.com
```

### Delete the application
```
kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/examples/2048/2048_full.yaml

```
### Delete the Terraform
```
terraform destroy
```

If it does not destroy cleanly you may have to go and finish off the deletion manually on the AWS console. Typically it will be the VPC, or an ENI or a subnet that you will have to delete manually.

====================================================================

[default]
aws_access_key_id = AKIA------------37L44
aws_secret_access_key = QVgNZ2------------q8LnI1NzmM
[esther]
aws_access_key_id = AKIA----------Z457L44
aws_secret_access_key = QWgNZ2H9x-----------8LnI1NzWM

[profile eks-admin]
role_arn = arn:aws:iam::??????????????:role/eks-admin
source_profile = esther