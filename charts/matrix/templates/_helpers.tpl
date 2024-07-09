{{/*
Expand the name of the chart.
*/}}
{{- define "matrix.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "matrix.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "matrix.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "matrix.labels" -}}
helm.sh/chart: {{ include "matrix.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: "matrix"
{{- end -}}

# TODO: Include labels from values
{{/*
Synapse specific labels
*/}}
{{- define "matrix.synapse.labels" -}}
{{- range $key, $val := .Values.synapse.labels -}}
{{ $key }}: {{ $val }}
{{- end }}
{{- end -}}

{{/*
Create image name that is used in the deployment
*/}}
{{- define "matrix.image" -}}
{{- if .Values.synapse.image.tag -}}
{{- printf "%s:%s" .Values.synapse.image.repository .Values.synapse.image.tag -}}
{{- else -}}
{{- printf "%s:%s" .Values.synapse.image.repository .Chart.AppVersion -}}
{{- end -}}
{{- end -}}

{{/*
Element specific labels
*/}}
{{- define "matrix.element.labels" -}}
{{- range $key, $val := .Values.element.labels }}
{{ $key }}: {{ $val }}
{{- end }}
{{- end -}}

{{/*
Mail relay specific labels
*/}}
{{- define "matrix.mail.labels" -}}
{{- range $key, $val := .Values.mail.relay.labels -}}
{{ $key }}: {{ $val }}
{{- end }}
{{- end -}}

{{/*
Synapse hostname prepended with https:// to form a complete URL
*/}}
{{- define "matrix.baseUrl" -}}
{{- printf "https://%s" .Values.matrix.hostname -}}
{{- end }}

{{/*
Helper function to get a postgres connection string for the database, with all of the auth and SSL settings automatically applied
*/}}
{{- define "matrix.postgresUri" -}}
{{- if .Values.postgresql.enabled -}}
postgres://{{ .Values.postgresql.global.postgresql.auth.username }}:{{ .Values.postgresql.global.postgresql.auth.password }}@{{ include "matrix.fullname" . }}-postgresql/%s{{ if .Values.postgresql.ssl }}?ssl=true&sslmode={{ .Values.postgresql.sslMode}}{{ end }}
{{- else -}}
postgres://{{ .Values.postgresql.global.postgresql.auth.username }}:{{ .Values.postgresql.global.postgresql.auth.password }}@{{ .Values.postgresql.global.postgresql.auth.hostname }}:{{ .Values.postgresql.port }}/%s{{ if .Values.postgresql.ssl }}?ssl=true&sslmode={{ .Values.postgresql.sslMode }}{{ end }}
{{- end }}
{{- end }}


{{/*
Helper function to get the postgres secret containing the database credentials
*/}}
{{- define "matrix.postgresql.secretName" -}}
{{- if and .Values.postgresql.enabled .Values.postgresql.global.postgresql.auth.existingSecret -}}
{{ .Values.postgresql.global.postgresql.auth.existingSecret }}
{{- else if and .Values.externalDatabase.enabled .Values.externalDatabase.existingSecret -}}
{{ .Values.externalDatabase.existingSecret }}
{{- else -}}
{{ template "matrix.fullname" . }}-db-secret
{{- end }}
{{- end }}

{{/*
Helper function to get postgres instance name
*/}}
{{- define "postgresql.name" -}}
{{- if .Values.postgresql.enabled -}}
{{ include "matrix.fullname" . }}-postgresql
{{- end }}
{{- end }}

{{/*
Helper function to get the coturn secret containing the sharedSecret
*/}}
{{- define "matrix.coturn.secretName" -}}
{{- if and .Values.coturn.enabled .Values.coturn.existingSecret -}}
{{ .Values.coturn.existingSecret }}
{{- else -}}
{{ template "matrix.fullname" . }}-coturn-secret
{{- end }}
{{- end }}

{{/*
Helper function to get the registration secret containing the sharedSecret
*/}}
{{- define "matrix.registration.secretName" -}}
{{- if .Values.matrix.registration.existingSecret -}}
{{ .Values.matrix.registration.existingSecret }}
{{- else if or .Values.matrix.registration.sharedSecret .Values.matrix.registration.generateSharedSecret -}}
{{ template "matrix.fullname" . }}-registration-secret
{{- end }}
{{- end }}
