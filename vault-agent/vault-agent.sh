#!/bin/bash


currentip=`ifconfig eth0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1`

# wait for all running
while [ 1 ]
do
  sleep 1
  echo "... waiting for  $i"
  count=0
  for (( c=0; c<$TOTAL_NODES; c++ ))
  do
    node_ip=$(ping -c1 vault$c | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
    if [ node_ip != "" ]; then
        ((count=count+1))
    fi
  done
  if [ $count == $TOTAL_NODES ]; then
      echo "all running"
      break
  fi
done

cat << EOF > /vault/config/agent.hcl
auto_auth {
  method {
    type = "approle"
    config = {
      role_id_file_path = "/etc/vault/agent/role_id.txt"
      secret_id_file_path = "/etc/vault/agent/secret_id.txt"
      remove_secret_id_file_after_reading = false
    }
  }

  sink {
    type = "file"
    config = {
      path = "/etc/vault/agent/sink-file"
    }
  }
}

vault {
  address = "http://vault2:8200"
}

listener "tcp" {
  address = "vault2:8100"
  tls_disable = true
}

template {
  error_on_missing_key = false

  contents = <<EOH
TESTING RENDERING
{{- with secret "kv/foo" }}
{{ .Data.data.bar }}
{{- end }}
  EOH
  destination = "/etc/vault/agent/baz.txt"
  command = ""
}
EOF

echo "[INFO] VAULT AGENT START"
vault agent -config=/vault/config/agent.hcl -log-level=DEBUG 2>&1 > /vault/logs/vault.log &

tail -f /vault/logs/vault.log
