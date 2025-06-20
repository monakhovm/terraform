apiVersion: v1
kind: Config
clusters:
- name: kind-cluster
  cluster:
    server: ${server_endpoint}
    certificate-authority-data: ${cluster_ca}
users:
- name: kind-user
  user:
    client-certificate-data: ${client_crt}
    client-key-data: ${client_key}
contexts:
- name: kind-context
  context:
    cluster: kind-cluster
    user: kind-user
current-context: kind-context
