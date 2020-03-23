def _k8s_configmap_impl(ctx):

  config_file=[]
  for (target, value) in ctx.attr.srcs.items():
    if len(target.files.to_list()) > 1:
      print(
        "\n###################################################################\n" +
        "This target " + str(target.label) + " contains multiples files.\n" +
        "Only the first file will be used.\n" +
        "###################################################################"
      )
    config_file.append("--from-file=%s=%s" % (value, target.files.to_list()[0].path))

  args = ctx.actions.args()
  args.add(ctx.files._kubectl[0].path)
  args.add(ctx.attr.name)
  args.add(' '.join(config_file))
  args.add(ctx.files._yq[0].path)
  args.add(ctx.outputs.out.path)

  command = ["$1", "create", "configmap", "--dry-run", "$2", "$3", "--output", "yaml"]

  if ctx.attr.namespace.strip():
    command+=[
      "|",
      "$4",
      "w",
      "- metadata.namespace", ctx.attr.namespace.strip()]

  if ctx.attr.labels.items():
    command+=[
      "| $4 w - metadata.labels.%s %s" % (key.strip(), value.strip()) for (key, value) in ctx.attr.labels.items()
    ]

  command+=[">", "$5"]

  ctx.actions.run_shell(
    inputs = ctx.files.srcs,
    tools  = ctx.files._kubectl + ctx.files._yq,
    outputs = [ctx.outputs.out],
    command = ' '.join(command),
    arguments = [args]
  )

  # return [
  #   DefaultInfo(
  #     files = depset([ctx.outputs.out])
  #   ),
  # ]

k8s_configmap = rule(
    implementation = _k8s_configmap_impl,
    attrs = {
        "srcs": attr.label_keyed_string_dict(
            mandatory = True,
            allow_empty = False,
            allow_files = True
        ),
        "namespace": attr.string(),
        "labels": attr.string_dict(),
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
    },
    outputs = {
      "out": "%{name}.configmap.yaml",
    },
)
