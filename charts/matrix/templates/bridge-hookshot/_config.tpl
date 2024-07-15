{{- define "hookshot_config.yaml" }}
bridge:
  domain: {{ .Values.bridges.hookshot.config.bridge.domain | default .Values.matrix.hostname }}
  url: {{ .Values.bridges.hookshot.config.bridge.url | default (include "matrix.baseUrl" .) }}
  {{- with .Values.bridges.hookshot.config.mediaUrl }}
  mediaUrl: {{ . }}
  {{- end }}
  port: {{ .Values.bridges.hookshot.config.bridge.port }}
  bindAddress: {{ .Values.bridges.hookshot.config.bridge.bindAddress }}

passFile: {{ .Values.bridges.hookshot.config.passFile }}

logging:
  level: {{ .Values.bridges.hookshot.config.logging.level }}
  colorize: {{ .Values.bridges.hookshot.config.logging.colorize }}
  json: {{ .Values.bridges.hookshot.config.logging.json }}
  timestampFormat: {{ .Values.bridges.hookshot.config.logging.timestampFormat }}

listeners:
{{- range .Values.bridges.hookshot.config.listeners }}
  - port: {{ .port }}
    bindAddress: {{ .bindAddress }}
    resources:
    {{- range .resources }}
      - {{ . }}
    {{- end }}
{{- end }}

{{- if .Values.bridges.hookshot.config.github.enabled }}
github:
  {{- with .Values.bridges.hookshot.config.github.enterpriseUrl }}
  enterpriseUrl: {{ . }}
  {{- end }}
  auth:
    id: {{ .Values.bridges.hookshot.config.github.auth.id }}
    privateKeyFile: {{ .Values.bridges.hookshot.config.github.auth.privateKeyFile }}

  webhook:
    secret: {{ .Values.bridges.hookshot.config.github.webhook.secret }}

  oauth:
    client_id: {{ .Values.bridges.hookshot.config.github.oauth.client_id }}
    client_secret: {{ .Values.bridges.hookshot.config.github.oauth.client_secret }}
    redirect_uri: {{ .Values.bridges.hookshot.config.github.oauth.redirect_uri }}

  defaultOptions:
    showIssueRoomLink: {{ .Values.bridges.hookshot.config.github.defaultOptions.showIssueRoomLink }}
    hotlinkIssues:
      prefix: {{ .Values.bridges.hookshot.config.github.defaultOptions.hotlinkIssues.prefix }}

  userIdPrefix: {{ .Values.bridges.hookshot.config.github.userIdPrefix }}
{{- end }}

{{- if .Values.bridges.hookshot.config.gitlab.enabled }}
gitlab:
  {{- with .Values.bridges.hookshot.config.github.instances }}
  instances:
    {{- toYaml . | nindent 8 }}
  {{- end }}

  webhook:
    secret: {{ .Values.bridges.hookshot.config.gitlab.webhook.secret }}
    publicUrl: {{ .Values.bridges.hookshot.config.gitlab.webhook.publicUrl }}

  userIdPrefix: {{ .Values.bridges.hookshot.config.gitlab.userIdPrefix }}

  commentDebounceMs: {{ .Values.bridges.hookshot.config.gitlab.commentDebounceMs }}
{{- end }}

{{- if .Values.bridges.hookshot.config.figma.enabled }}
figma:
  # (Optional) Configure this to enable Figma support
  publicUrl: {{ .Values.bridges.hookshot.config.figma.publicUrl }}
  instances:
  {{- with .Values.bridges.hookshot.config.figma.instances }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- if .Values.bridges.hookshot.config.generic.enabled }}
generic:
  outbound: {{ .Values.bridges.hookshot.config.generic.outbound }}
  enableHttpGet: {{ .Values.bridges.hookshot.config.generic.enableHttpGet }}
  urlPrefix: {{ .Values.bridges.hookshot.config.generic.urlPrefix }}
  userIdPrefix: {{ .Values.bridges.hookshot.config.generic.userIdPrefix }}
  allowJsTransformationFunctions: {{ .Values.bridges.hookshot.config.generic.allowJsTransformationFunctions }}
  waitForComplete: {{ .Values.bridges.hookshot.config.generic.waitForComplete }}
{{- end }}

{{- if .Values.bridges.hookshot.config.feeds.enabled }}
feeds:
  pollConcurrency: {{ .Values.bridges.hookshot.config.feeds.pollConcurrency }}
  pollIntervalSeconds: {{ .Values.bridges.hookshot.config.feeds.pollIntervalSeconds }}
  pollTimeoutSeconds: {{ .Values.bridges.hookshot.config.feeds.pollTimeoutSeconds }}
{{- end }}

{{- if .Values.bridges.hookshot.config.provisioning.enabled }}
provisioning:
  secret: {{ .Values.bridges.hookshot.config.provisioning.secret }}
{{- end }}

{{- if or .Values.bridges.hookshot.config.bot.displayname .Values.bridges.hookshot.config.bot.avatar }}
bot:
  {{- with .Values.bridges.hookshot.config.bot.displayname }}
  displayName: {{ . }}
  {{- end }}
  {{- with .Values.bridges.hookshot.config.bot.avatar }}
  avatar: {{ . }}
  {{- end }}
{{- end }}

{{- with .Values.bridges.hookshot.config.serviceBots }}
{{- range . }}
serviceBots:
  - localpart: {{ .localport }}
    displayname: {{ .displayname }}
    avatar: {{ .avatar }}
    prefix: {{ .prefix }}
    service: {{ .service }}
{{- end }}
{{- end }}

metrics:
  enabled: {{ .Values.bridges.hookshot.config.metrics.enabled }}

{{- with .Values.bridges.hookshot.config.cache.redisUri }}
cache:
  redisUri: {{ . }}
{{- end }}

{{- with .Values.bridges.hookshot.config.queue.redisUri }}
queue:
  redisUri: {{ . }}
{{- end }}

{{- if .Values.bridges.hookshot.config.widgets.enabled }}
widgets:
  addToAdminRooms: {{ .Values.bridges.hookshot.config.widgets.addToAdminRooms }}
  {{- with .Values.bridges.hookshot.config.widgets.disallowedIpRanges }}
  disallowedIpRanges:
    - {{ . }}
  {{- end }}
  roomSetupWidget:
    addOnInvite: {{ .Values.bridges.hookshot.config.widgets.roomSetupWidget.addOnInvite }}
  publicUrl: {{ .Values.bridges.hookshot.config.widgets.publicUrl }}
  branding:
    widgetTitle: {{ .Values.bridges.hookshot.config.widgets.branding.widgetTitle }}
  {{- with .Values.bridges.hookshot.config.widgets.openIdOverrides }}
  openIdOverrides:
    my-local-server: {{ . }}
  {{- end }}{{/* end if hookshot.confg.widgets.openIdOverrides */}}
{{- end }}{{/* end if hookshot.confg.widgets.openIdOverrides */}}

{{- if .Values.bridges.hookshot.config.sentry.dsn }}
sentry:
  dns: {{ .Values.bridges.hookshot.config.sentry.dsn }}
  environment: {{ .Values.bridges.hookshot.config.sentry.environment }}
{{- end }}

{{- if .Values.bridges.hookshot.config.permissions }}
{{- range .Values.bridges.hookshot.config.permissions }}
permissions:
  - actor: {{ .actor }}
    services:
    {{- range .services }}
      - service: {{ .service }}
        level: {{ .level }}
    {{- end }}
{{- end }}{{/* range bridges.htmlDateInZone.contains.permissions */}}
{{- end }}{{/* if bridges.hookshot.config.permissions */}}
{{- end }}{{/* end define template config.yaml */}}
