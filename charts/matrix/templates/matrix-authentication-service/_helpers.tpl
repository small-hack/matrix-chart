{{/*
Expand the name of the chart.
*/}}
{{- define "matrixAuthenticationService.name" -}}
{{ printf "%s-mas" (include "matrix.name" .) }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "matrixAuthenticationService.fullname" -}}
{{ printf "%s-mas" (include "matrix.fullname" .) }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "matrixAuthenticationService.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "matrixAuthenticationService.selectorLabels" -}}
app.kubernetes.io/name: {{ include "matrixAuthenticationService.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Helper function to get postgres instance name
*/}}
{{- define "matrixAuthenticationService.postgresql.hostname" -}}
{{- if .Values.matrixAuthenticationServicePostgresql.enabled -}}
{{ template "postgresql.v1.primary.fullname" .Subcharts.postgresql }}
{{- else -}}
{{- .Values.matrixAuthenticationService.externalDatabase.hostname -}}
{{- end }}
{{- end }}

{{/*
Helper function to get the postgres secret containing the database credentials
*/}}
{{- define "matrixAuthenticationService.postgresql.secretName" -}}
{{- if and .Values.matrixAuthenticationServicePostgresql.enabled .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.existingSecret -}}
{{ .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.existingSecret }}
{{- else if and .Values.matrixAuthenticationService.externalDatabase.enabled .Values.matrixAuthenticationService.externalDatabase.existingSecret -}}
{{ .Values.matrixAuthenticationService.externalDatabase.existingSecret }}
{{- else -}}
{{ template "matrixAuthenticationService.fullname" . }}-db-secret
{{- end }}
{{- end }}

{{/*
Helper function to get postgres hostname secret key
*/}}
{{- define "matrixAuthenticationService.postgresql.secretKeys.hostname" -}}
{{- if and .Values.matrixAuthenticationServicePostgresql.enabled .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.existingSecret -}}
{{- .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.secretKeys.databaseHostname -}}
{{- else if and .Values.matrixAuthenticationService.externalDatabase.enabled .Values.matrixAuthenticationService.externalDatabase.existingSecret -}}
{{- .Values.matrixAuthenticationService.externalDatabase.secretKeys.databaseHostname -}}
{{- else -}}
{{- printf "hostname" }}
{{- end }}
{{- end }}

{{/*
Helper function to get postgres database secret key
*/}}
{{- define "matrixAuthenticationService.postgresql.secretKeys.database" -}}
{{- if and .Values.matrixAuthenticationServicePostgresql.enabled .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.existingSecret -}}
{{- .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.secretKeys.database -}}
{{- else if and .Values.matrixAuthenticationService.externalDatabase.enabled .Values.matrixAuthenticationService.externalDatabase.existingSecret -}}
{{- .Values.matrixAuthenticationService.externalDatabase.secretKeys.database -}}
{{- else -}}
{{- printf "database" }}
{{- end }}
{{- end }}

{{/*
Helper function to get postgres user secret key
*/}}
{{- define "matrixAuthenticationService.postgresql.secretKeys.user" -}}
{{- if and .Values.matrixAuthenticationServicePostgresql.enabled .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.existingSecret -}}
{{- .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.secretKeys.databaseUsername -}}
{{- else if and .Values.matrixAuthenticationService.externalDatabase.enabled .Values.matrixAuthenticationService.externalDatabase.existingSecret -}}
{{- .Values.matrixAuthenticationService.externalDatabase.secretKeys.databaseUsername -}}
{{- else -}}
{{- printf "username" }}
{{- end }}
{{- end }}

{{/*
Helper function to get postgres password secret key
*/}}
{{- define "matrixAuthenticationService.postgresql.secretKeys.password" -}}
{{- if and .Values.matrixAuthenticationServicePostgresql.enabled .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.existingSecret -}}
{{- .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.secretKeys.userPasswordKey -}}
{{- else if and .Values.matrixAuthenticationService.externalDatabase.enabled .Values.matrixAuthenticationService.externalDatabase.existingSecret -}}
{{- .Values.matrixAuthenticationService.externalDatabase.secretKeys.userPasswordKey -}}
{{- else -}}
{{- printf "password" }}
{{- end }}
{{- end }}

{{/*
Helper function to get postgres ssl mode
*/}}
{{- define "matrixAuthenticationService.postgresql.sslEnvVars" -}}
{{- if and .Values.matrixAuthenticationServicePostgresql.enabled .Values.matrixAuthenticationServicePostgresql.sslmode -}}
- name: PGSSLMODE
  value: {{ .Values.matrixAuthenticationServicePostgresql.sslmode }}
- name: PGSSLCERT
  value: {{ .Values.matrixAuthenticationServicePostgresql.sslcert }}
- name: PGSSLKEY
  value: {{ .Values.matrixAuthenticationServicePostgresql.sslkey }}
- name: PGSSLROOTCERT
  value: {{ .Values.matrixAuthenticationServicePostgresql.sslrootcert }}
{{- else if .Values.matrixAuthenticationService.externalDatabase.enabled -}}
- name: PGSSLMODE
  value: {{ .Values.matrixAuthenticationService.externalDatabase.sslmode }}
- name: PGSSLCERT
  value: {{ .Values.matrixAuthenticationService.externalDatabase.sslcert }}
- name: PGSSLKEY
  value: {{ .Values.matrixAuthenticationService.externalDatabase.sslkey }}
- name: PGSSLROOTCERT
  value: {{ .Values.matrixAuthenticationService.externalDatabase.sslrootcert }}
{{- end }}
{{- end }}

{{/*
Helper function to get a postgres connection string for the database, with all of the auth and SSL settings automatically applied
*/}}
{{- define "matrixAuthenticationService.postgresUri" -}}
{{- if .Values.matrixAuthenticationServicePostgresql.enabled -}}
postgres://{{ .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.username }}:{{ .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.password }}@{{ include "matrixAuthenticationService.postgresql.hostname" . }}/%s{{ if .Values.matrixAuthenticationServicePostgresql.ssl }}?ssl=true&sslmode={{ .Values.matrixAuthenticationServicePostgresql.sslMode}}{{ end }}
{{- else -}}
postgres://{{ .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.username }}:{{ .Values.matrixAuthenticationServicePostgresql.global.postgresql.auth.password }}@{{ include "matrixAuthenticationService.postgresql.hostname" . }}:{{ .Values.matrixAuthenticationServicePostgresql.port }}/%s{{ if .Values.matrixAuthenticationServicePostgresql.ssl }}?ssl=true&sslmode={{ .Values.matrixAuthenticationServicePostgresql.sslMode }}{{ end }}
{{- end }}
{{- if .Values.matrixAuthenticationService.externalDatabase.enabled -}}
postgres://{{ .Values.matrixAuthenticationService.externalDatabase.username }}:{{ .Values.matrixAuthenticationService.externalDatabase.password }}@{{ .Values.matrixAuthenticationService.externalDatabase.hostname }}/%s{{ if .Values.matrixAuthenticationServicePostgresql.ssl }}?ssl=true&sslmode={{ .Values.matrixAuthenticationServicePostgresql.sslMode}}{{ end }}
{{- else -}}
postgres://{{ .Values.matrixAuthenticationService.externalDatabase.username }}:{{ .Values.matrixAuthenticationService.externalDatabase.password }}@{{ .Values.matrixAuthenticationService.externalDatabase.hostname }}:{{ .Values.matrixAuthenticationServicePostgresql.port }}/%s{{ if .Values.matrixAuthenticationServicePostgresql.ssl }}?ssl=true&sslmode={{ .Values.matrixAuthenticationServicePostgresql.sslMode }}{{ end }}
{{- end }}
{{- end }}

{{/*
Helper function to get the matrix secret?
*/}}
{{- define "matrixAuthenticationService.matrix.secretName" -}}
{{- if .Values.matrixAuthenticationService.mas.matrix.existingSecret -}}
{{ .Values.matrixAuthenticationService.mas.matrix.existingSecret }}
{{- else -}}
{{ template "matrixAuthenticationService.fullname" . }}-matrix-secret
{{- end }}
{{- end }}
