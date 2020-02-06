docker build -t amitdewangan/multi-client -f ./client/Dockerfile ./client
docker build -t amitdewangan/multi-server -f ./server/Dockerfile ./server
docker build -t amitdewangan/multi-worker -f ./worker/Dockerfile ./worker
docker push amitdewangan/multi-client
docker push amitdewangan/multi-server
docker push amitdewangan/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amitdewangan/multi-server