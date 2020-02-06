docker build -t amitdewangan/multi-client:latest -t amitdewangan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amitdewangan/multi-server:latest -t amitdewangan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amitdewangan/multi-worker:latest -t amitdewangan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push amitdewangan/multi-client:latest
docker push amitdewangan/multi-server:latest
docker push amitdewangan/multi-worker:latest

docker push amitdewangan/multi-client:$SHA
docker push amitdewangan/multi-server:$SHA
docker push amitdewangan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amitdewangan/multi-server:$SHA
kubectl set image deployments/client-deployment client=amitdewangan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amitdewangan/multi-worker:$SHA