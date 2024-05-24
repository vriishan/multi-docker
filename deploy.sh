docker build -t vrushab97/multi-client:latest -t vrushab97/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vrushab97/multi-server:latest -t vrushab97/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vrushab97/multi-worker:latest -t vrushab97/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vrushab97/multi-client:latest
docker push vrushab97/multi-client:$SHA
docker push vrushab97/multi-server:latest
docker push vrushab97/multi-server:$SHA
docker push vrushab97/multi-worker:latest
docker push vrushab97/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vrushab97/multi-server:$SHA
kubectl set image deployments/client-deployment client=vrushab97/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vrushab97/multi-worker:$SHA