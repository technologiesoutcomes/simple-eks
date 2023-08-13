resource "kubectl_manifest" "namespace_esther" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Namespace
apiVersion: v1
metadata:
  name: esther
  labels:
    name: esther
EOF
}

resource "kubectl_manifest" "role_esther" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: esther
  namespace: esther
rules:
  - apiGroups: [""]
    resources: ["*"]
    resourceNames: ["*"]
    verbs: ["*"]
EOF
}

resource "kubectl_manifest" "role_binding_esther" {
  yaml_body = <<-EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: esther
  namespace: esther
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: esther
subjects:
  - kind: User
    name: esther
    namespace: esther
EOF
}
