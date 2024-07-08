
{{- define "matrix.discord_mautrix.as_token" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{- define "matrix.discord_mautrix.hs_token" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{/* correct secret names */}}
{{- define "matrix.discord_mautrix.configSecret" -}}
{{- if .Values.bridges.discord_mautrix.existingSecret -}}
{{ .Values.bridges.discord_mautrix.existingSecret }}
{{- else -}}
{{ template "matrix.fullname" . }}-discord-config
{{- end -}}
{{- end -}}

{{- define "matrix.discord_mautrix.registrationSecret" -}}
{{ template "matrix.fullname" . }}-discord-registration
{{- end -}}

{{- define "matrix.discord_mautrix.pvc" -}}
{{- if .Values.bridges.discord_mautrix.volume.existingClaim -}}
{{ .Values.bridges.discord_mautrix.volume.existingClaim }}
{{- else -}}
{{ template "matrix.fullname" . }}-discord-bridge
{{- end -}}
