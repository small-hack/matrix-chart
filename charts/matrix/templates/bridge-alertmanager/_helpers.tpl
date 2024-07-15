{{- define "matrix.alertmanager.as_token" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{- define "matrix.alertmanager.hs_token" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{- define "matrix.alertmanager.webhook_secret" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{/* registration secret name */}}
{{- define "matrix.alertmanager.registrationSecret" -}}
{{- if .Values.bridges.alertmanager.existingSecret.registration -}}
{{ .Values.bridges.alertmanager.existingSecret.registration }}
{{- else -}}
{{ template "matrix.fullname" . }}-alertmanager-registration
{{- end -}}
{{- end -}}
