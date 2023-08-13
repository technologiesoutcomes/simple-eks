resource "kubectl_manifest" "namespace_arsene" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Namespace
apiVersion: v1
metadata:
  name: arsene
  labels:
    name: arsene
EOF
}

resource "kubectl_manifest" "role_arsene" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: arsene
  namespace: arsene
rules:
  - apiGroups: [""]
    resources: ["*"]
    resourceNames: ["*"]
    verbs: ["*"]
EOF
}

resource "kubectl_manifest" "role_binding_arsene" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: arsene
  namespace: arsene
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: arsene
subjects:
  - kind: User
    name: arsene
    namespace: arsene
EOF
}
