default: image

docker-image = dhswt/php-nginx

assemble:
	exec ./scripts/Makefile-assemble.sh

images: image-5-6-phusion image-7-0-phusion image-7-1-phusion image-7-2-phusion

image-5-6-phusion:
	docker build --squash \
		--build-arg PHP_VERSION=5.6 \
		-t $(docker-image):5.6-phusion \
		./phusion-common

image-7-0-phusion:
	docker build --squash \
		--build-arg PHP_VERSION=7.0 \
		-t $(docker-image):7.0-phusion \
		./phusion-common

image-7-1-phusion:
	docker build --squash \
		--build-arg PHP_VERSION=7.1 \
		-t $(docker-image):7.1-phusion \
		./phusion-common

image-7-2-phusion:
	docker build --squash \
		--build-arg PHP_VERSION=7.2 \
		-t $(docker-image):7.2-phusion \
		./phusion-common

push: push-5-6-phusion push-7-0-phusion push-7-1-phusion push-7-2-phusion

push-5-6-phusion:
	docker push $(docker-image):5.6-phusion 

push-7-0-phusion:
	docker push $(docker-image):7.0-phusion

push-7-1-phusion:
	docker push $(docker-image):7.1-phusion

push-7-2-phusion:
	docker push $(docker-image):7.2-phusion

show-images:
	docker images | grep "$(docker-image)"
	
clear:
	rm -rf ./build

# Remove dangling images
clean-images:
	docker images -a -q \
		--filter "reference=$(docker-image)" \
		--filter "dangling=true" \
	| xargs docker rmi

# Remove all images
clear-images:
	docker images -a -q \
		--filter "reference=$(docker-image)" \
	| xargs docker rmi
