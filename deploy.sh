docker build -t gutothomas/multi-client:latest -t gutothomas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gutothomas/multi-server:latest -t gutothomas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gutothomas/multi-worker:latest -t gutothomas/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push gutothomas/multi-client:latest
docker push gutothomas/multi-server:latest
docker push gutothomas/multi-worker:latest
docker push gutothomas/multi-client:$SHA
docker push gutothomas/multi-server:$SHA
docker push gutothomas/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deploy/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deploy/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deploy/worker-deployment worker=stephengrider/multi-worker:$SHA
