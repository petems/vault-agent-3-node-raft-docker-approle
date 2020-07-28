# vault-agent-3-node-raft-docker-approle

Basic example of vault-agent with AppRole with a 3 node raft storage Vault cluster

## Build

Run in this directory:
```
docker-compose build
```

## Start

Run in this directory:
```
docker-compose up -d
```

## View TOKENS

Run in this direcoty:
```
docker-compose logs|grep TOKEN
```
output
```
vault0_1  | [INFO] VAULT ROOT TOKEN: s.fOCUAwUjp6Tdh3NtPgKAa0MY
vault0_1  | [INFO] VAULT UNSEAL TOKEN: HT0rgLmbDD2hEbbIUJWbInMavR7rtLXgXui3baB4lms=
```

## Destroy
Run in this directory:
```
docker-compose down
```

## vault-agent Setup

Get the token from the logs:
```
docker-compose logs|grep "VAULT ROOT TOKEN: "
export VAULT_TOKEN=s.fOCUAwUjp6Tdh3NtPgKAa0MY
rm -rf terraform.tfstate
cd terraform/
terraform apply
```

Restart the Vault agent container (as it's stubbed out on boot):

```
docker-compose -f docker-compose.yml up -d
```

Check the agent logs:

```
docker logs vault-agent-3-node-raft-docker-approle_vaultagent_1
```

See contents rendered:

```
cat /vault-agent/baz.txt
TESTING RENDERING
qux
```