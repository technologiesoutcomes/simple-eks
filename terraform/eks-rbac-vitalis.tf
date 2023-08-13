resource "kubectl_manifest" "namespace_vitalis" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Namespace
apiVersion: v1
metadata:
  name: vitalis
  labels:
    name: vitalis
EOF
}

resource "kubectl_manifest" "role_vitalis" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: vitalis
  namespace: vitalis
rules:
  - apiGroups: [""]
    resources: ["*"]
    resourceNames: ["*"]
    verbs: ["*"]
EOF
}

resource "kubectl_manifest" "role_binding_vitalis" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: vitalis
  namespace: vitalis
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: vitalis
subjects:
  - kind: User
    name: vitalis
    namespace: vitalis
EOF
}
