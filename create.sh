kubectl create -f mongo-svc.yaml
kubectl create -f mongo1-svc.yaml
kubectl create -f mongo2-svc.yaml
kubectl create -f mongo-rc.yaml --validate=false
kubectl create -f mongo1-rc.yaml --validate=false
kubectl create -f mongo2-rc.yaml --validate=false
