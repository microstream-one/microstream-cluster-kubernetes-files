{{/*
Expand the name of the chart.
*/}}
{{- define "es-cluster.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name (meaning it contains the chart and the release name).
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "es-cluster.fullname" -}}
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

{{- define "es-cluster.kafka.fullname" -}}
{{- printf "%s-%s" (include "es-cluster.fullname" . | trunc 58 | trimSuffix "-" ) "kafka" }}
{{- end }}

{{- define "es-cluster.master-node.fullname" -}}
{{- printf "%s-%s" (include "es-cluster.fullname" . | trunc 52 | trimSuffix "-" ) "master-node" }}
{{- end }}

{{- define "es-cluster.master-node-storage.fullname" -}}
{{- printf "%s-%s" (include "es-cluster.fullname" . | trunc 44 | trimSuffix "-" ) "master-node-storage" }}
{{- end }}

{{- define "es-cluster.storage-backups.fullname" -}}
{{- printf "%s-%s" (include "es-cluster.fullname" . | trunc 48 | trimSuffix "-" ) "storage-backups" }}
{{- end }}

{{- define "es-cluster.user-app.fullname" -}}
{{- printf "%s-%s" (include "es-cluster.fullname" . | trunc 55 | trimSuffix "-" ) "user-app" }}
{{- end }}

{{- define "es-cluster.proxy.fullname" -}}
{{- printf "%s-%s" (include "es-cluster.fullname" . | trunc 58 | trimSuffix "-" ) "proxy" }}
{{- end }}

{{- define "es-cluster.storage-node.fullname" -}}
{{- printf "%s-%s" (include "es-cluster.fullname" . | trunc 59 | trimSuffix "-" ) "node" }}
{{- end }}

{{- define "es-cluster.storage-node-headless.fullname" -}}
{{- printf "%s-%s" (include "es-cluster.fullname" . | trunc 50 | trimSuffix "-" ) "node-headless" }}
{{- end }}

{{- define "es-cluster.writer-proxy.fullname" -}}
{{- printf "%s-%s" (include "es-cluster.fullname" . | trunc 51 | trimSuffix "-" ) "writer-proxy" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "es-cluster.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "es-cluster.common.labels" -}}
helm.sh/chart: {{ include "es-cluster.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "es-cluster.labels" -}}
{{ include "es-cluster.common.labels" . }}
{{ include "es-cluster.selectorLabels" . }}
{{- end }}

{{- define "es-cluster.kafka.labels" -}}
{{ include "es-cluster.common.labels" . }}
{{ include "es-cluster.kafka.selectorLabels" . }}
{{- end }}

{{- define "es-cluster.master-node.labels" -}}
{{ include "es-cluster.common.labels" . }}
{{ include "es-cluster.master-node.selectorLabels" . }}
{{- end }}

{{- define "es-cluster.proxy.labels" -}}
{{ include "es-cluster.common.labels" . }}
{{ include "es-cluster.proxy.selectorLabels" . }}
{{- end }}

{{- define "es-cluster.storage-node.labels" -}}
{{ include "es-cluster.common.labels" . }}
{{ include "es-cluster.storage-node.selectorLabels" . }}
{{- end }}

{{- define "es-cluster.writer-proxy.labels" -}}
{{ include "es-cluster.common.labels" . }}
{{ include "es-cluster.writer-proxy.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "es-cluster.selectorLabels" -}}
app.kubernetes.io/name: {{ include "es-cluster.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "es-cluster.kafka.selectorLabels" -}}
{{ include "es-cluster.selectorLabels" . }}
app.kubernetes.io/component: kafka
{{- end }}

{{- define "es-cluster.master-node.selectorLabels" -}}
{{ include "es-cluster.selectorLabels" . }}
app.kubernetes.io/component: master-node
{{- end }}

{{- define "es-cluster.proxy.selectorLabels" -}}
{{ include "es-cluster.selectorLabels" . }}
app.kubernetes.io/component: proxy
{{- end }}

{{- define "es-cluster.storage-node.selectorLabels" -}}
{{ include "es-cluster.selectorLabels" . }}
app.kubernetes.io/component: node
{{- end }}

{{- define "es-cluster.writer-proxy.selectorLabels" -}}
{{ include "es-cluster.selectorLabels" . }}
app.kubernetes.io/component: writer-proxy
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "es-cluster.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "es-cluster.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
