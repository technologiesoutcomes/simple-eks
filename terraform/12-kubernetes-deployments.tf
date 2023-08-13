##module "namespace" {
##  source  = "gruntwork-io/namespace/kubernetes"
##  version = "0.5.1"
##  name    = "ci-cd"
##  # insert the 1 required variable here
##}

##module "deploy" {
##  source  = "terraform-iaac/deployment/kubernetes"
##  ## version = "1.4.3"
##  name          = "jenkins"
##  namespace     = "default" ## module.namespace.name
##  image         = "jenkins/jenkins:latest"
##  internal_port = [
##    {
##      name          = "web-access"
##      internal_port = "8080"
##      host_port     = "80"
##    },
##    {
##      name          = "another"
##      internal_port = "8090"
##    }
##  ]
##
##  readiness_probe = {
##    http_get = {
##      path   = "/health"
##      port   = 8080
##      scheme = "HTTP"
##    }
##    success_threshold     = 1
##    failure_threshold     = 3
##    initial_delay_seconds = 10
##    period_seconds        = 30
##    timeout_seconds       = 3
##  }
##}
