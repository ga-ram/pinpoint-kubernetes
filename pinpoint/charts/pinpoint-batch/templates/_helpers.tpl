{{/*
Expand the name of the chart.
*/}}
{{- define "pinpoint-batch.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pinpoint-batch.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pinpoint-batch.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pinpoint-batch.labels" -}}
helm.sh/chart: {{ include "pinpoint-batch.chart" . }}
{{ include "pinpoint-batch.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pinpoint-batch.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pinpoint-batch.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create Mysql enabled flag
*/}}
{{- define "pinpoint-batch.mysql.enabled" -}}
{{- default "true" .Values.mysql.enabled -}}
{{- end }}

{{/*
Create Mysql Username
*/}}
{{- define "pinpoint-batch.mysql.username" -}}
{{- default "root" .Values.mysql.username -}}
{{- end }}

{{/*
Create Mysql Password
*/}}
{{- define "pinpoint-batch.mysql.password" -}}
{{- default "pinpoint" .Values.mysql.password -}}
{{- end }}

{{/*
Create a mysql url even when there's missing values
*/}}
{{- define "pinpoint-batch.mysql.url" -}}
{{- default "pinpoint-mysql" .Values.mysql.host -}}
{{- end }}

{{/*
Create a mysql port even when there's missing values
*/}}
{{- define "pinpoint-batch.mysql.port" -}}
{{- default 3306 .Values.mysql.port | int -}}
{{- end }}

{{/*
Create a fully qualified mysql url
*/}}
{{- define "pinpoint-batch.mysql.full-url" -}}
{{- $host :=  default "pinpoint-mysql" .Values.mysql.host }}
{{- $port :=  default 3306 .Values.mysql.port | int }}
{{- printf "jdbc:mysql://%s:%d/%s?characterEncoding=UTF-8" $host $port "pinpoint" }}
{{- end }}

{{/*
Create a fully qualified mysql url for metadata
*/}}
{{- define "pinpoint-batch.mysql.full-metaurl" -}}
{{- $host :=  default "pinpoint-mysql" .Values.mysql.host }}
{{- $port :=  default 3306 .Values.mysql.port | int }}
{{- printf "jdbc:mysql://%s:%d/%s?characterEncoding=UTF-8" $host $port "metadata" }}
{{- end }}

{{/*
Create Zookeeper address
*/}}
{{- define "pinpoint-batch.zookeeper.address" -}}
{{- default "pinpoint-zookeeper" .Values.zookeeper.host -}}
{{- end }}