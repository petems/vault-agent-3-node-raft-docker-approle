FROM hashicorp/vault-enterprise:1.5.4_ent

ADD start.sh /start.sh
RUN apk add bash && chmod +x /start.sh

ENV VAULT_ADDR=http://localhost:8200

ENTRYPOINT ["/start.sh"]
