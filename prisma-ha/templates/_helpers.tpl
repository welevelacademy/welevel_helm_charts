{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "prisma-ha.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prisma-ha.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "prisma-ha.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "prisma-ha.labels" -}}
helm.sh/chart: {{ include "prisma-ha.chart" . }}
{{ include "prisma-ha.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "prisma-ha.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prisma-ha.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create a default fully qualified rabbitmq name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prisma-ha.rabbitmq.fullname" -}}
{{- $name := default "rabbitmq" .Values.rabbitmq.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified postgresql name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prisma-ha.postgresql.fullname" -}}
{{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use.
*/}}
{{- define "prisma-ha.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "prisma-ha.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Set the proper RAbbitMQ uri. If rabbitmq is installed as part of this chart, build uri,
else use user-provided uri
*/}}
{{- define "prisma-ha.messaging.uri" }}
{{- if .Values.rabbitmq.enabled -}}
{{- $host := include "prisma-ha.rabbitmq.fullname" . -}}
{{- printf "amqp://%s:%s@%s:%g" .Values.rabbitmq.auth.username .Values.rabbitmq.auth.password $host .Values.rabbitmq.service.ports.amqp }}
{{- else -}}
{{- .Values.messaging.rabbitUri | quote }}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified name for the secret that contains the database password.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prisma-ha.databaseSecret.fullname" -}}
{{- if .Values.postgresql.enabled -}}
{{- include "prisma-ha.postgresql.fullname" . }}
{{- else -}}
{{- include "prisma-ha.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Set the proper name for the secretKeyRef key that contains the database password.
*/}}
{{- define "prisma-ha.databaseSecret.key" -}}
{{- if .Values.postgresql.enabled -}}
postgresql-password
{{- else -}}
db-password
{{- end -}}
{{- end -}}

{{/*
Set the proper database host. If postgresql is installed as part of this chart, use the default service name,
else use user-provided host
*/}}
{{- define "prisma-ha.database.host" }}
{{- if .Values.postgresql.enabled -}}
{{- include "prisma-ha.postgresql.fullname" . }}
{{- else -}}
{{- .Values.database.host | quote }}
{{- end -}}
{{- end -}}

{{/*
Set the proper database port. If postgresql is installed as part of this chart, use the default postgresql port,
else use user-provided port
*/}}
{{- define "prisma-ha.database.port" }}
{{- if .Values.postgresql.enabled -}}
{{- default "5432" ( .Values.postgresql.containerPorts.postgresql | quote ) }}
{{- else -}}
{{- .Values.database.port | quote }}
{{- end -}}
{{- end -}}
