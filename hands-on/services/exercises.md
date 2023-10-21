

```
kubectl create namespace ????-multi-container
```
edit the yaml and add the namespace to the yaml
vim multi-container-pod.yaml
```
kubectl apply -f multi-container-pod.yaml
kubectl get pods -A
kubectl logs multi-container -c sidecar
kubectl logs multi-container -c sidecar -n ????-multi-container
kubectl get pods -A
kubectl get pod multi-container -o wide
kubectl get pod multi-container -o wide -n ????-multi-container
kubectl get pod multi-container -o yaml -n ????-multi-container
```
===================================================================================================
```
kubectl create namespace ????-pod2pod

kubectl get pod nginx-85f7bb8c6b-kfl5j -o wide

kubectl get pod nginx-85f7bb8c6b-kfl5j -o yaml

kubectl run busybox --image=busybox -n ????-pod2pod --rm -it --restart=Never -- wget 10.10.104.15:8080
```
===================================================================================================

```
kubectl create namespace ????-services-1

kubectl run echoserver-1 -n ????-services-1 --image=k8s.gcr.io/echoserver:1.10 --restart=Never \
--port=8080

kubectl create service clusterip echoserver-1 -n ????-services-1 --tcp=80:8080
```
====================================================================================================
```
kubectl create namespace ????-services-2

kubectl run echoserver-2 -n ????-services-2 --image=k8s.gcr.io/echoserver:1.10 --restart=Never \
--port=8080 --expose
```
===================================================================================================
```
kubectl create namespace ????-services-3

kubectl create deployment echoserver-3 -n ????-services-3 --image=k8s.gcr.io/echoserver:1.10 \
--replicas=5

kubectl expose deployment echoserver-3 -n ????-services-3 --port=80 --target-port=8080

kubectl get deployments -n ????-services-3

kubectl get services -n ????-services-3

kubectl describe service echoserver-3 -n ????-services-3

kubectl get endpoints echoserver-3 -n ????-services-3

kubectl describe endpoints echoserver-3 -n ????-services-3
```
========================================================================================================
```
kubectl create namespace ????-services-4

kubectl run echoserver-4 -n ????-services-4 --image=k8s.gcr.io/echoserver:1.10 --restart=Never \
--port=8080 -l app=echoserver-4

kubectl create service clusterip echoserver-4 -n ????-services-4 --tcp=5005:8080

kubectl get pod,service ????-services-4

wget <???>:5005 --timeout=5 --tries=1

kubectl run tmp --image=busybox --restart=Never -it --rm \
-- wget 172.20.26.36:5005
```


========================================================================================================

```
kubectl create namespace ????-services-5

kubectl run echoserver-5 -n ????-services-5 --image=k8s.gcr.io/echoserver:1.10 --restart=Never \
--port=8080 -l app=echoserver-5

kubectl create service nodeport echoserver-5 -n ????-services-5 --tcp=5005:8080

kubectl get pod,service -n ????-services-5

kubectl run tmp --image=busybox --restart=Never -it --rm \
-- wget 172.20.57.199:5005


kubectl get nodes -o \
jsonpath='{ $.items[*].status.addresses[?(@.type=="InternalIP")].address }'

Check the SG and ensure it allows the traffic on the port
wget 3.249.87.49:30792


```
