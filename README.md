# Configure CLI access to AWS

### Configure the user1 profile
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

Create and delete the cluster using Terraform with you default profile

### Configure role 
** Edit the ~/.aws/config file as follows
```
[profile eks-admin]
role_arn = arn:aws:iam::??????????????:role/eks-admin
source_profile = user1
```

### Check role assuming
```
aws sts get-caller-identity --profile eks-admin
```


### Update the cluster kube config file
```
aws eks update-kubeconfig \
  --name techoutcomes \
  --region us-east-1 \
  --profile eks-admin 
```

### Connect to the cluster and check the nodes
```
kubectl get nodes
kubectl get pods

```

### Deploy application
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.4/docs/examples/2048/2048_full.yaml

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
kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.4/docs/examples/2048/2048_full.yaml

```
### Delete the Terraform
```
terraform destroy
```
