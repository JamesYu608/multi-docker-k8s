docker build -t jamesyu608/mutli-client:latest -t jamesyu608/mutli-client:$SHA -f ./client/Dockerfile ./client
docker build -t jamesyu608/mutli-server:latest -t jamesyu608/mutli-server:$SHA -f ./server/Dockerfile ./server
docker build -t jamesyu608/mutli-worker:latest -t jamesyu608/mutli-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jamesyu608/mutli-client:latest
docker push jamesyu608/mutli-server:latest
docker push jamesyu608/mutli-worker:latest

docker push jamesyu608/mutli-client:$SHA
docker push jamesyu608/mutli-server:$SHA
docker push jamesyu608/mutli-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jamesyu608/mutli-server:$SHA
kubectl set image deployments/client-deployment client=jamesyu608/mutli-client:$SHA
kubectl set image deployments/worker-deployment server=jamesyu608/mutli-worker:$SHA