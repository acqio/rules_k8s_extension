load("@bazel_skylib//lib:dicts.bzl", "dicts")
load(":helpers.bzl", "create_command")

_common_attr = {
    "_kubectl": attr.label(
        default = Label("@kubectl//file"),
        cfg = "host",
        executable = True,
        allow_single_file = True,
    ),
    "_yq": attr.label(
        default = Label("@yq//file"),
        cfg = "host",
        executable = True,
        allow_single_file = True,
    ),
    "annotations": attr.string_dict(),
    "from_file": attr.label_keyed_string_dict(
        allow_empty = False,
        allow_files = True,
    ),
    "from_literal": attr.string_dict(
        allow_empty = True,
    ),
    "labels": attr.string_dict(),
    "namespace": attr.string(),
}

def _impl(ctx):
    ctx.actions.run_shell(
        inputs = ctx.files.from_file,
        tools = ctx.files._kubectl + ctx.files._yq,
        outputs = [ctx.outputs.out],
        command = create_command(ctx),
    )

    return [
        DefaultInfo(
            files = depset([ctx.outputs.out]),
        ),
    ]

k8s_configmap = rule(
    implementation = _impl,
    attrs = dicts.add(
        _common_attr,
        {
            "_api": attr.string(default = "configmap"),
        },
    ),
    outputs = {
        "out": "%{name}.configmap.yaml",
    },
)

k8s_secret = rule(
    implementation = _impl,
    attrs = dicts.add(
        _common_attr,
        {
            "_api": attr.string(default = "secret"),
            "_type": attr.string(
                default = "generic",
                doc = """
                Possible types are: docker-registry, generic, tls.
                This rule supports only the generic type, for now.
                """,
            ),
        },
    ),
    outputs = {
        "out": "%{name}.secret.yaml",
    },
)
