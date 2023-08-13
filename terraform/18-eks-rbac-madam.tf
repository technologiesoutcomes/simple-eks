resource "kubectl_manifest" "namespace_madam" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Namespace
apiVersion: v1
metadata:
  name: madam
  labels:
    name: madam
EOF
}

resource "kubectl_manifest" "role_madam" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: madam
  namespace: madam
rules:
  - apiGroups: [""]
    resources: ["*"]
    resourceNames: ["*"]
    verbs: ["*"]
EOF
}

resource "kubectl_manifest" "role_binding_madam" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: madam
  namespace: madam
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: madam
subjects:
  - kind: User
    name: madam
    namespace: madam
EOF
}
