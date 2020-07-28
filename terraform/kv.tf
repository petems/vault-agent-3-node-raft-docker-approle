resource "vault_mount" "kv2" {
  path        = "kv"
  type        = "kv-v2"
}

resource "vault_generic_secret" "example" {
  path = "kv/foo/"

  data_json = <<EOT
{
  "bar":   "qux"
}
EOT

  depends_on = [vault_mount.kv2]
}