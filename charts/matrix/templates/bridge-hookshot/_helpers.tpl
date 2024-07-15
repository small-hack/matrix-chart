{{- define "matrix.hookshot.as_token" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{- define "matrix.hookshot.hs_token" -}}
{{- randAlphaNum 64 -}}
{{- end -}}

{{- define "matrix.hookshot.configmap" -}}
{{- if and .Values.bridges.hookshot.existingConfigMap (not .Values.bridges.hookshot.existingSecret.config) -}}
{{ .Values.bridges.hookshot.existingConfigMap }}
{{- else -}}
{{ template "matrix.fullname" . }}-hookshot-config
{{- end -}}
{{- end -}}

{{/* correct secret names */}}
{{- define "matrix.hookshot.configSecret" -}}
{{- if and (not .Values.bridges.hookshot.existingConfigMap) .Values.bridges.hookshot.existingSecret.config -}}
{{ .Values.bridges.hookshot.existingSecret }}
{{- end -}}
{{- end -}}

{{- define "matrix.hookshot.passkeySecret" -}}
{{- if and .Values.bridges.hookshot.enabled .Values.bridges.hookshot.existingSecret.passkey -}}
{{ .Values.bridges.hookshot.existingSecret.passkey }}
{{- else -}}
{{ template "matrix.fullname" . }}-hookshot-passkey
{{- end -}}
{{- end -}}

{{- define "matrix.hookshot.registrationSecret" -}}
{{- if and .Values.bridges.hookshot.enabled .Values.bridges.hookshot.existingSecret.registration -}}
{{ .Values.bridges.hookshot.existingSecret.registration }}
{{- else -}}
{{ template "matrix.fullname" . }}-hookshot-registration
{{- end -}}
{{- end -}}
