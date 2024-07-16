{{- define "rss_feeds.yml" }}
feeds:
  {{- range .Values.bridges.rss.feeds }}
  - name: {{ .name }}
    url: {{ .url }}
    room: {{ .room }}
  {{- end }}
{{- end }}{{/* end define template rss_feeds.yml */}}
