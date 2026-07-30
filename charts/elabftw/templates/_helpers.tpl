{{/*
Expand the chart name.
*/}}
{{- define "elabftw.name" -}}
{{- default .Chart.Name .Values.elabftw.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the fullname.
*/}}
{{- define "elabftw.fullname" -}}
{{- if .Values.elabftw.fullnameOverride -}}
{{- .Values.elabftw.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else if contains .Chart.Name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "elabftw.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Common labels.
*/}}
{{- define "elabftw.labels" -}}
helm.sh/chart: {{ include "elabftw.name" . }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "elabftw.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Application secret.
*/}}
{{- define "elabftw.secretName" -}}
{{- default (printf "%s-secret" (include "elabftw.fullname" .)) .Values.elabftw.secrets.existingSecret -}}
{{- end -}}

{{/*
Database host.
*/}}
{{- define "elabftw.database.host" -}}
{{- if .Values.mysql.enabled -}}
{{ printf "%s-mysql" .Release.Name }}
{{- else -}}
{{ .Values.externalDatabase.host }}
{{- end -}}
{{- end -}}

{{/*
Database port.
*/}}
{{- define "elabftw.database.port" -}}
{{- if .Values.mysql.enabled -}}
3306
{{- else -}}
{{ default 3306 .Values.externalDatabase.port }}
{{- end -}}
{{- end -}}

{{/*
Database name.
*/}}
{{- define "elabftw.database.name" -}}
{{- if .Values.mysql.enabled -}}
{{ .Values.mysql.auth.database }}
{{- else -}}
{{ .Values.externalDatabase.database }}
{{- end -}}
{{- end -}}

{{/*
Database connection secret name.
This secret is owned by the eLabFTW chart.
*/}}
{{- define "elabftw.database.secretName" -}}
{{- if .Values.externalDatabase.existingSecret -}}
{{- .Values.externalDatabase.existingSecret -}}
{{- else -}}
{{- printf "%s-db" (include "elabftw.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Database username key.
*/}}
{{- define "elabftw.database.usernameKey" -}}
{{- if .Values.externalDatabase.existingSecret -}}
{{- default "username" .Values.externalDatabase.usernameKey -}}
{{- else -}}
username
{{- end -}}
{{- end -}}

{{/*
Database password key.
*/}}
{{- define "elabftw.database.passwordKey" -}}
{{- if .Values.externalDatabase.existingSecret -}}
{{- default "password" .Values.externalDatabase.passwordKey -}}
{{- else -}}
password
{{- end -}}
{{- end -}}

{{/*
Redis secret name.
*/}}
{{- define "elabftw.redis.secretName" -}}
{{- default (include "elabftw.secretName" .) .Values.elabftw.redis.existingSecret -}}
{{- end -}}

{{/*
Redis password key.
*/}}
{{- define "elabftw.redis.passwordKey" -}}
{{- default "password" .Values.elabftw.redis.passwordKey -}}
{{- end -}}
