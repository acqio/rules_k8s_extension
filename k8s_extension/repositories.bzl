load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def repositories():
    excludes = native.existing_rules().keys()

    if "bazel_skylib" not in excludes:
        http_archive(
            name = "bazel_skylib",
            urls = [
                "https://github.com/bazelbuild/bazel-skylib/archive/1.0.2.tar.gz",
            ],
            sha256 = "e5d90f0ec952883d56747b7604e2a15ee36e288bb556c3d0ed33e818a4d971f2",
            strip_prefix = "bazel-skylib-1.0.2",
        )

    http_file(
        name = "kubectl",
        urls = [
            "https://storage.googleapis.com/kubernetes-release/release/v1.18.6/bin/linux/amd64/kubectl",
        ],
        sha256 = "62fcb9922164725c7cba5747562f2ad2f4d834ad0a458c1e4c794cc203dcdfb3",
        executable = True,
    )

    http_file(
        name = "yq",
        urls = [
            "https://github.com/mikefarah/yq/releases/download/3.2.1/yq_linux_amd64",
        ],
        sha256 = "11a830ffb72aad0eaa7640ef69637068f36469be4f68a93da822fbe454e998f8",
        executable = True,
    )
