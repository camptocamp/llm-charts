{{/*
Expand the name of the chart.
*/}}
{{- define "text-generation-inference.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "text-generation-inference.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "text-generation-inference.fullname" -}}
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
Allow customization of the instance label value.
*/}}
{{- define "text-generation-inference.instance-name" -}}
{{- default (printf "%s-%s" .Release.Name .Release.Namespace) .Values.instanceLabelOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* 
Define shared selector labels,
This is an immutable field: this should not change between upgrade 
*/}}
{{- define "text-generation-inference.selectorLabels" -}}
app.kubernetes.io/name: {{ template "text-generation-inference.name" . }}
app.kubernetes.io/instance: {{ template "text-generation-inference.instance-name" . }}
{{- end }}

{{/*
Define shared labels.
*/}}
{{- define "text-generation-inference.labels" -}}
{{ include "text-generation-inference.selectorLabels" . }}
helm.sh/chart: {{ template "text-generation-inference.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}


{{/*
Construct the namespace for all namespaced resources.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
Preserve the default behavior of the Release namespace if no override is provided.
*/}}
{{- define "text-generation-inference.namespace" -}}
{{- if .Values.namespaceOverride -}}
{{- .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- .Release.Namespace -}}
{{- end -}}
{{- end -}}
