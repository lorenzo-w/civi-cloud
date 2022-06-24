{{- define "dolibarr.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "dolibarr.pvcName" -}}
{{- printf "%s-www-data" (include "common.names.fullname" .) }}
{{- end }}

{{- define "dolibarr.cmName" -}}
{{- printf "%s-config" (include "common.names.fullname" .) -}}
{{- end }}

{{- define "mariadb.serviceHost" -}}
{{- printf "%s.%s.svc.cluster.local" .Values.mariadb.fullnameOverride .Release.Namespace -}}
{{- end }}