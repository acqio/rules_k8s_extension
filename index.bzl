load(
    "//internal:k8s_extension.bzl",
    _k8s_configmap = "k8s_configmap",
    _k8s_secret = "k8s_secret",
)

k8s_configmap = _k8s_configmap
k8s_secret = _k8s_secret
