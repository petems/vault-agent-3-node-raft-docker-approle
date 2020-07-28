FROM hashicorp/vault-enterprise:1.5.4_ent

ADD vault-agent.sh /vault-agent.sh
RUN apk add bash && chmod +x /vault-agent.sh

ENV VAULT_ADDR=http://vault2:8200

ENTRYPOINT ["/vault-agent.sh"]
