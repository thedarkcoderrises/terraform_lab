provider "docker" {
  host = "tcp://127.0.0.1:1234/"
}

resource "docker_image" "activemq" {
  name = "activemq:5.15.6"
}

resource "docker_container" "amq" {
  name = "amq"
  image = "${docker_image.activemq.latest}"
  ports {
    external = 8161
    internal = 8161
  }
  ports {
    external = 61616
    internal = 61616
  }
}