docker build --platform="linux/amd64" -t frkr/casa-work .
docker run -it --rm --name n8n -p 8080:80 frkr/casa-work
