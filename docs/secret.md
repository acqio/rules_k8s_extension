<a name="k8s_secret"></a>
## k8s_secret

```python
k8s_secret(name, annotations, from_file, from_literal, namespace, labels)
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
      <td><code>annotations</code></td>
      <td>
        <code>String dict, optional</code>
        <p>Annotations to be added.</p>
      </td>
    </tr>
    <tr>
      <td><code>from_file</code></td>
      <td>
        <code>Label keyed String dict, required</code>
        <p>A dictionary where the key is a file and the value is a name.</p>
        <p>The name is used in the data field of secret.</p>
      </td>
    </tr>
    <tr>
      <td><code>from_literal</code></td>
      <td>
        <code>String dict, optional.</code>
      </td>
    </tr>
    <tr>
      <td><code>namespace</code></td>
      <td>
        <code>String, optional.</code>
      </td>
    </tr>
    <tr>
      <td><code>labels</code></td>
      <td>
        <code>String dict, optional</code>
        <p>Labels to be added.</p>
      </td>
    </tr>
  </tbody>
</table>
