{{- define "rss_config.yml" }}
homeserver: {{ .Values.bridges.rss.registration.url | default (include "matrix.baseUrl" .) | quote }}
access_token: {{ include "matrix.rss.as_token" . }}

bot:
  user: {{ .Values.bridges.rss.config.bot.user }}
  display_name: {{ .Values.bridges.rss.config.bot.display_name }}
  {{- with .Values.bridges.rss.config.bot.display_name }}
  avatar: {{ . }}
  {{- end }}
  default_room: {{ .Values.bridges.rss.config.bot.default_room }}
  interval: {{ .Values.bridges.rss.config.bot.interval }}
{{- end }}{{/* end define template rss_config.yml */}}
