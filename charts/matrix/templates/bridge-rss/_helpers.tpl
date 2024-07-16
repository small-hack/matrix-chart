{{- define "matrix.rss.as_token" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{- define "matrix.rss.hs_token" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{/* registration secret name */}}
{{- define "matrix.rss.registrationSecret" -}}
{{- if .Values.bridges.rss.existingSecret.registration -}}
{{ .Values.bridges.rss.existingSecret.registration }}
{{- else -}}
{{ template "matrix.fullname" . }}-rss-registration
{{- end -}}
{{- end -}}

{{/* config secret name */}}
{{- define "matrix.rss.configSecret" -}}
{{- if .Values.bridges.rss.existingSecret.config -}}
{{ .Values.bridges.rss.existingSecret.config }}
{{- else -}}
{{ template "matrix.fullname" . }}-rss-config
{{- end -}}
{{- end -}}

{{/* feeds secret name */}}
{{- define "matrix.rss.feedsSecret" -}}
{{- if .Values.bridges.rss.existingSecret.feeds -}}
{{ .Values.bridges.rss.existingSecret.feeds }}
{{- else -}}
{{ template "matrix.fullname" . }}-rss-feeds
{{- end -}}
{{- end -}}
