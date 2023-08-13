module "argocd" {
  //source = "github.com/aigisuk/terraform-kuberenetes-argocd"
  source = "aigisuk/argocd/kubernetes"

  admin_password = "administrator"
  insecure       = true
  ##values_file    = "./config/argocd+vault-plugin_values.yaml"
  values_file    = file("${path.module}/config/argocd+vault-plugin_values.yaml")
  
}