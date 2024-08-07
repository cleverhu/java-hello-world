.phony: image
image:
	@docker buildx build --platform linux/amd64,linux/arm64 -t deeplythink/java-hello-world:latest . --push
