resource "kubectl_manifest" "namespace_leslie" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Namespace
apiVersion: v1
metadata:
  name: leslie
  labels:
    name: leslie
EOF
}

resource "kubectl_manifest" "role_leslie" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: leslie
  namespace: leslie
rules:
  - apiGroups: [""]
    resources: ["*"]
    resourceNames: ["*"]
    verbs: ["*"]
EOF
}

resource "kubectl_manifest" "role_binding_leslie" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: leslie
  namespace: leslie
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: leslie
subjects:
  - kind: User
    name: leslie
    namespace: leslie
EOF
}
