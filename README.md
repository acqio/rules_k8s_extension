# K8s Extension Rules for Bazel

## Setup

```python
local_repository(
    name = "rules_k8s_extension",
    path = "./tools/bazel_rules/rules_k8s_extension
)

load("@rules_k8s_extension//:repositories.bzl", "k8s_extension_repositories")
k8s_extension_repositories()
```

## Rules

<a name="k8s_configmap"></a>
## k8s_configmap

```python
k8s_configmap(name, srcs, namespace, labels)
```

For example, if the BUILD file contains:

```python
k8s_configmap(
  name = "configmap"
  srcs = {
    "//path/to/target:foo" : "foo.conf"
  },
  namespace = "foo-ns",
  labels = {
    "bar" : "b",
  }
)
```

<table class="table table-condensed table-bordered table-params">
  <colgroup>
    <col class="col-param" />
    <col class="param-description" />
  </colgroup>
  <thead>
    <tr>
      <th colspan="2">Attributes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>name</code></td>
      <td>
        <code>Name, required</code>
        <p>A unique name for this rule.</p>
      </td>
    </tr>
    <tr>
      <td><code>srcs</code></td>
      <td>
        <code>Label keyed String dict, required</code>
        <p>A dictionary where the key is a file and the value is a name.</p>
        <p>The name is used in the data field of configmap.</p>
      </td>
    </tr>
    <tr>
      <td><code>namespace</code></td>
      <td>
        <code>String, optional.</code>
        <p>The namespace for configmap.</p>
      </td>
    </tr>
    <tr>
      <td><code>labels</code></td>
      <td>
        <code>String dict, optional</code>
        <p>Labels to be added to configmap.</p>
      </td>
    </tr>
  </tbody>
</table>
