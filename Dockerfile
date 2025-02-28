FROM docker.n8n.io/n8nio/n8n:next

USER root
RUN apk update && apk add --no-cache zip wget curl jq git

ENV N8N_PORT="80"
# TODO Cluster - HEALTHCHECK CMD curl --fail http://localhost/healthz || exit 1

USER node
RUN mkdir ~/.n8n/nodes && cd ~/.n8n/nodes && npm install \
  n8n-nodes-guuid-generator \
  n8n-nodes-kommo \
  n8n-nodes-text-manipulation

ENV N8N_RUNNERS_ENABLED="true"
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS="true"
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
