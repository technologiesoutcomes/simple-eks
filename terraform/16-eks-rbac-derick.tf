resource "kubectl_manifest" "namespace_derick" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Namespace
apiVersion: v1
metadata:
  name: derick
  labels:
    name: derick
EOF
}

resource "kubectl_manifest" "role_derick" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: derick
  namespace: derick
rules:
  - apiGroups: [""]
    resources: ["*"]
    resourceNames: ["*"]
    verbs: ["*"]
EOF
}

resource "kubectl_manifest" "role_binding_derick" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: derick
  namespace: derick
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: derick
subjects:
  - kind: User
    name: derick
    namespace: derick
EOF
}
