resource "kubectl_manifest" "namespace_sunny" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Namespace
apiVersion: v1
metadata:
  name: sunny
  labels:
    name: sunny
EOF
}

resource "kubectl_manifest" "role_sunny" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: sunny
  namespace: sunny
rules:
  - apiGroups: [""]
    resources: ["*"]
    resourceNames: ["*"]
    verbs: ["*"]
EOF
}

resource "kubectl_manifest" "role_binding_sunny" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: sunny
  namespace: sunny
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: sunny
subjects:
  - kind: User
    name: sunny
    namespace: sunny
EOF
}
