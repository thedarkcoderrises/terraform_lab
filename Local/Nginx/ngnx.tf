provider "docker" {
  host = "tcp://127.0.0.1:1234/"
}

resource "docker_image" "mynginx" {
  name = "mynginx:1"
}

resource "docker_container" "mynginx" {
  name = "nginx"
  image = "${docker_image.mynginx.latest}"
  ports {
    external = 8081
    internal = 80
  }
  links = ["hystrix1","hystrix2"]
}

# docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:1234:1234 bobrik/socat TCP-LISTEN:1234,fork UNIX-CONNECT:/var/run/docker.sock
# and then export DOCKER_HOST=tcp://localhost:1234.
# source ~/.bash_profile