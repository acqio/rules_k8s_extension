load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def k8s_extension_repositories():

    excludes = native.existing_rules().keys()

    if "kubectl" not in excludes:

        http_file(
            name = "kubectl",
            executable = True,
            sha256 = "9daf696f5609ab41ac491886de5e87e35d8d3076f65defc27602a476800a97bf",
            urls = [
                "https://storage.googleapis.com/kubernetes-release/release/v1.17.4/bin/linux/amd64/kubectl"
            ],
        )

    if "yq" not in excludes:

        http_file(
            name = "yq",
            executable = True,
            sha256 = "11a830ffb72aad0eaa7640ef69637068f36469be4f68a93da822fbe454e998f8",
            urls = [
                "https://github.com/mikefarah/yq/releases/download/3.2.1/yq_linux_amd64"
            ],
        )
