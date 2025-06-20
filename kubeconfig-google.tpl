apiVersion: v1
kind: Config
clusters:
- name: ${cluster_name}
  cluster:
    server: ${cluster_endpoint}
    certificate-authority-data: ${cluster_ca}
users:
- name: ${cluster_name}
  user:
    token: ${access_token}
contexts:
- name: ${cluster_name}
  context:
    cluster: ${cluster_name}
    user: ${cluster_name}
current-context: ${cluster_name}
