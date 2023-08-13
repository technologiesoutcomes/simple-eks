resource "kubectl_manifest" "namespace_ekstestuser" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Namespace
apiVersion: v1
metadata:
  name: ekstestuser
  labels:
    name: ekstestuser
EOF
}

resource "kubectl_manifest" "role_ekstestuser" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: ekstestuser
  namespace: ekstestuser
rules:
  - apiGroups: [""]
    resources: ["*"]
    resourceNames: ["*"]
    verbs: ["*"]
EOF
}

resource "kubectl_manifest" "role_binding_ekstestuser" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: ekstestuser
  namespace: ekstestuser
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: ekstestuser
subjects:
  - kind: User
    name: ekstestuser
    namespace: ekstestuser
EOF
}
