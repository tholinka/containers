target "docker-metadata-action" {}

variable "VERSION" {
  // renovate: datasource=docker depName=dockerhub.io/library/alpine
	default = "3.21"
}

variable "SOURCE" {
	default = "https://github.com/alpinelinux/docker-alpine"
}

group "default" {
	targets = ["image-local"]
}

target "image" {
	inherits = ["docker-metadata-action"]
	labels = {
		"org.opencontainers.image.source" = "${SOURCE}"
	}
}

target "image-local" {
	inherits = ["image"]
	output = ["type=docker"]
}

target "image-all" {
	inherits = ["image"]
	platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
