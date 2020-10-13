# Tech Evaluation

## Prerequisites
- Git
- Docker
- Docker-Compose

## Setup
Build MarbleCutter Docker image: Checkout the MarbleCutter-Virtual repo from
[here](https://github.com/shuvozula/marblecutter-virtual) and build the docker image to your local Docker repository:
```bash
git clone https://github.com/shuvozula/marblecutter-virtual
cd marblecutter-virtual/
docker build -t marblecutter-virtual .
```

## Run
Start the services from this Repo. With the `MarbleCutter-virtual` Docker image, we can now safely start our software
stack:
```bash
docker-compose up
```
This will build the Rails6 App docker image and use the prebuilt MarbleCutter docker image from the previous step.
It'll also create the Nginx container and mount the `nginx.conf` and `uwsgi_params` files for mapping routes.

## Browse the Landsat COG Service
- Navigate to `http://localhost` in your favorite browser and you'll notice the Landsat COGs all loaded, each linking to
the MarbleCutter's Preview page. For more details on the app, visit the app README [here](containers/app/README.md)

## Notes
- The MarbleCutter service
    - Equipped with a GDAL container with Python3.8 support.
    - Equipped with uwsgi (http-socket`) server.
        - The Nginx proxy server location for `uwsgi_pass` is unable to honor `proxy_set_header` directives, so the
          Host header isn't being sent in pure Uwsgi, causing the frontend to break.
    - The only working combination is using Http at the moment and the MarbleCutter service is available publicly via
      Http at `http://localhost:8000/`

## Ideal Scenario
- Helmchart and Kubernetes to orchestrate the services, using Nginx Ingress Controller (more setup, but addresses the 12FA Dev/Prod disparity).
- Full UWSGI support for Nginx + MarbleCutter with horizontally scaled out MarbleCutter worker nodes, with Nginx sidecar proxy.
- Rails 6 service migrated to FastAPI Python service for speed improvements and ease of use.