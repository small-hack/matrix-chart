{{- define "rss_config.yml" }}
app_service:
  id: {{ .Values.bridges.rss.registration.id }}
  sender_localpart: {{ .Values.bridges.rss.registration.sender_localpart }}
  homeserver: {{ .Values.bridges.rss.registration.url | default (include "matrix.baseUrl" .) | quote }}
  as_token: {{ include "matrix.rss.as_token" . }}
  hs_token: {{ include "matrix.rss.hs_token" . }}

bot:
  user: "@{{ .Values.bridges.rss.config.bot.user }}:{{ .Values.matrix.serverName }}"
  {{- with .Values.bridges.rss.config.bot.display_name }}
  display_name: {{ . }}
  {{- end }}
  {{- with .Values.bridges.rss.config.bot.avatar }}
  avatar: {{ . }}
  {{- end }}
  default_room: {{ .Values.bridges.rss.config.bot.default_room }}
  interval: {{ .Values.bridges.rss.config.bot.interval }}

log:
  level: {{ .Values.bridges.rss.config.log.level }}

{{- end }}{{/* end define template rss_config.yml */}}
