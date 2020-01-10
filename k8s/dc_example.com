apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment # Name of our deployment
  labels:
    app: nginx
spec:
  replicas: 3      # number of pods
  selector:        # this is how deployment knows what pod to manage
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx  
        image: nginx:11    # Image version
        ports:
        - containerPort: 80
