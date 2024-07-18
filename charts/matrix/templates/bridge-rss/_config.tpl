{{- define "rss_config.yml" }}
app_service:
  id: {{ .Values.bridges.rss.registration.id | quote }}
  sender_localpart: {{ .Values.bridges.rss.registration.sender_localpart | quote }}
  homeserver: {{ .Values.bridges.rss.registration.url | default (include "matrix.baseUrl" .) | quote }}

bot:
  user: "@{{ .Values.bridges.rss.config.bot.user }}:{{ .Values.matrix.serverName }}"
  {{- with .Values.bridges.rss.config.bot.display_name }}
  display_name: {{ . | quote }}
  {{- end }}
  {{- with .Values.bridges.rss.config.bot.avatar }}
  avatar: {{ . | quote }}
  {{- end }}
  default_room: {{ .Values.bridges.rss.config.bot.default_room | quote }}
  interval: {{ .Values.bridges.rss.config.bot.interval }}

log:
  level: {{ .Values.bridges.rss.config.log.level | quote }}
{{- end }}{{/* end define template rss_config.yml */}}
