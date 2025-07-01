FROM docker.n8n.io/n8nio/n8n:next

# Custom Alpine packages
USER root
RUN apk update && apk add --no-cache zip wget curl jq git

# Custom N8N nodes
USER node
RUN mkdir ~/.n8n/nodes && cd ~/.n8n/nodes && npm install \
  n8n-nodes-kommo \
  n8n-nodes-elevenlabs \
  @splainez/n8n-nodes-phonenumber-parser \
  n8n-nodes-chatwoot \
  n8n-nodes-globals

ENV N8N_PORT="80"
ENV N8N_RUNNERS_ENABLED="true"
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS="true"
ENV OFFLOAD_MANUAL_EXECUTIONS_TO_WORKERS="true"
#ENV QUEUE_HEALTH_CHECK_ACTIVE="true"
#HEALTHCHECK CMD curl --fail http://localhost/healthz || exit 1

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
