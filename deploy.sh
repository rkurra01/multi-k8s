docker build -t rkurra01/multi-client:latest -t rkurra01/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rkurra01/multi-server:latest -t rkurra01/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rkurra01/multi-worker:latest -t rkurra01/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rkurra01/multi-client:latest
docker push rkurra01/multi-server:latest
docker push rkurra01/multi-worker:latest 
docker push rkurra01/multi-client:$SHA
docker push rkurra01/multi-server:$SHA
docker push rkurra01/multi-worker:$SHA 
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rkurra01/multi-server:$SHA
kubectl set image deployments/client-deployment client=rkurra01/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rkurra01/multi-worker:$SHA