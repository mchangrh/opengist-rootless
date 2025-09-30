variable "OWNER_NAME" {
  type = string
  default ="mchangrh"
}

variable "IMAGE_NAME" {
  type = string
  default ="opengist-rootless"
}

target "default" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/${OWNER_NAME}/${IMAGE_NAME}:latest"]
  platforms = ["linux/amd64", "linux/arm64"]
}