DOCKER:=@docker
APP_NAME=things
VERSION=$(shell git rev-parse --short HEAD)
REGISTRY=maissacrement/neurotothing
PWD:=`pwd`

env:=.env
-include $(env)

build:
	${DOCKER} build -t ${APP_NAME} .

xserver-dev:
	xhost + # give foward auth
	${DOCKER} run --rm -it --privileged \
		--env "TERM=xterm-256color" \
		--env DISPLAY=${DISPLAY} \
		-v /dev/bus/usb:/dev/bus/usb \
		-v /var/run/dbus/:/var/run/dbus \
		-v $(HOME)/.Xauthority:/root/.Xauthority \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--cap-add=SYS_ADMIN --cap-add=NET_ADMIN \
		--net=host \
	${APP_NAME} /bin/bash -c "python3 app.py"
	xhost -

tag-latest:
	@echo 'create tag latest'
	@docker tag $(APP_NAME) $(REGISTRY):latest

tag-version:
	@echo 'create tag $(VERSION)'
	@docker tag $(APP_NAME) $(REGISTRY):$(VERSION)

push: tag-version tag-latest
	@echo 'publish $(VERSION) to $(DOCKER_REPO)'
	@docker push $(REGISTRY):$(VERSION)
	@docker push $(REGISTRY):latest

xserver:
	xhost + # give foward auth
	${DOCKER} run --rm -it --privileged \
		--env "TERM=xterm-256color" \
		--env DISPLAY=${DISPLAY} \
		-v /dev/bus/usb:/dev/bus/usb \
		-v /var/run/dbus/:/var/run/dbus \
		-v $(HOME)/.Xauthority:/root/.Xauthority \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--cap-add=SYS_ADMIN --cap-add=NET_ADMIN \
		--net=host \
	$(REGISTRY) /bin/bash -c "python3 app.py"
	xhost -