resource "kubectl_manifest" "namespace_moules" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Namespace
apiVersion: v1
metadata:
  name: moules
  labels:
    name: moules
EOF
}

resource "kubectl_manifest" "role_moules" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: moules
  namespace: moules
rules:
  - apiGroups: [""]
    resources: ["*"]
    resourceNames: ["*"]
    verbs: ["*"]
EOF
}

resource "kubectl_manifest" "role_binding_moules" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: moules
  namespace: moules
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: moules
subjects:
  - kind: User
    name: moules
    namespace: moules
EOF
}
