resource "kubectl_manifest" "my_service" {
    yaml_body = file("${path.module}/config/nginx-deployment.yml")
}

##data "kubectl_filename_list" "manifests" {
##    pattern = "./manifests/*.yaml"
##}
##
##resource "kubectl_manifest" "test" {
##    count = length(data.kubectl_filename_list.manifests.matches)
##    yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
##}

resource "kubectl_manifest" "games_2048_namespace" {
    yaml_body = file("${path.module}/config/games-2048/2048_namespace_v254.yaml")
}

resource "kubectl_manifest" "games_2048_deployment" {
    yaml_body = file("${path.module}/config/games-2048/2048_deployment_v254.yaml")
}

resource "kubectl_manifest" "games_2048_service" {
    yaml_body = file("${path.module}/config/games-2048/2048_service_v254.yaml")
}

resource "kubectl_manifest" "games_2048_ingress" {
    yaml_body = file("${path.module}/config/games-2048/2048_ingress_v254.yaml")
}