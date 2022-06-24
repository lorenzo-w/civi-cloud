{{- define "onlyoffice.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "mariadb.serviceHost" -}}
{{- printf "%s.%s.svc.cluster.local" .Values.mariadb.fullnameOverride .Release.Namespace -}}
{{- end }}