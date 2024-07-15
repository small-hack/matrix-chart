{{- define "matrix.discord_mautrix.as_token" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{- define "matrix.discord_mautrix.hs_token" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{/* config secret name */}}
{{- define "matrix.discord_mautrix.configSecret" -}}
{{- if .Values.bridges.discord_mautrix.existingSecret.config -}}
{{ .Values.bridges.discord_mautrix.existingSecret.config }}
{{- else -}}
{{ template "matrix.fullname" . }}-discord-config
{{- end -}}
{{- end -}}

{{/* registration secret name */}}
{{- define "matrix.discord_mautrix.registrationSecret" -}}
{{- if .Values.bridges.discord_mautrix.existingSecret.registration -}}
{{ .Values.bridges.discord_mautrix.existingSecret.registration }}
{{- else -}}
{{ template "matrix.fullname" . }}-discord-registration
{{- end -}}
{{- end -}}
