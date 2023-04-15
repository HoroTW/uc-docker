# An example Dockerfile for undedected-chromedriver

This Dockerfile builds an image with undetected-chromedriver and a VNC server.
The entrypoint ensures that the VNC server is running before the script is executed.
To execute your script you should mount the `mount` directory into the containers `/opt/wd`
directory.

Example command to build and run the container:
```bash
docker build -t undetected-chromedriver . && docker run -it --rm --volume ./mount:/opt/wd --name undetected-chromedriver -e VNC_PASSWORD=123456 -p 5900:5900 undetected-chromedriver python script.py
```
The VNC server is now accessible on localhost:5900 with password 123456
You could also use the docker-compose.yml file.

## If you don't see the Browser: 
The chrome window will be closed if your script ends.
Also don't use `input()` to stop your script from stopping because if you run 
the script in a non-interactive shell it will not be able to open the input 
stream which results in an error and termination of the script.
You could use `while True: sleep(10)` to keep the script running.
