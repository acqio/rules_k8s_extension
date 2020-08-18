def _kube_from_args(from_file, from_literal):
    _argument = []

    if not (len(from_file) or len(from_literal)):
        fail("At least one of the attributes must be filled: (from_file, from_literal).")

    for (srcs, value) in from_file:
        if len(srcs.files.to_list()) > 1:
            print(
                "\n###################################################################\n" +
                "The target " + str(srcs.label) + " contains multiple files.\n" +
                "Only the first file (" + srcs.files.to_list()[0].short_path + ") will be used.\n" +
                "###################################################################",
            )
        file_path = srcs.files.to_list()[0].path
        _argument.append("--from-file=%s=%s" % (value.strip(), file_path))

    for (key, value) in from_literal.items():
        _argument.append("--from-literal=%s=%s" % (key.strip(), value.strip()))

    return " ".join(_argument)

def create_command(ctx):
    kubectl_path = ctx.files._kubectl[0].path
    yq_path = ctx.files._yq[0].path
    name = ctx.attr.name
    namespace = ctx.attr.namespace
    api = ctx.attr._api
    api_type = ctx.attr._type if hasattr(ctx.attr, "_type") else ""
    annotations = ctx.attr.annotations or {}
    labels = ctx.attr.labels or {}
    args = _kube_from_args(ctx.attr.from_file.items(), ctx.attr.from_literal)
    outfile = ctx.outputs.out.path

    command = [kubectl_path, "create", api, api_type, "--dry-run=client", name, args, "--output", "yaml"]

    if namespace.strip():
        command += ["|", yq_path, "write", "- metadata.namespace", namespace.strip()]

    for (key, value) in annotations.items():
        command += ["|", yq_path, "write -", "'metadata.annotations.(%s)' '%s'" % (key.strip(), value.strip())]

    for (key, value) in labels.items():
        command += ["|", yq_path, "write -", "'metadata.labels.(%s)' '%s'" % (key.strip(), value.strip())]

    command += [">", outfile, "&&", yq_path, "v", outfile]

    return " ".join(command)
