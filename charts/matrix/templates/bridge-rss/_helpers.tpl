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
