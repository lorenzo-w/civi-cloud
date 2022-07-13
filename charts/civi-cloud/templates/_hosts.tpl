{{/*
Generate hostname from domain and subdomain.

Params:
  - service - String - Required - Name of the service to generate a hostname for.
  - context - Context - Required - Parent context.

Usage:
{{ include "get_hostname" (dict "service" "my-service" "context" $) }}

*/}}
{{- define "get_hostname" -}}
  {{ $subdomain := .service }}
  {{- if hasKey .context.Values.subdomains .service }}
    {{- $subdomain = index .context.Values.subdomains .service -}}
  {{- end -}}
  {{- if or (eq $subdomain "") (eq $subdomain "@") -}}
    {{ .context.Values.domain }}
  {{- else -}}
    {{ printf "%s.%s" $subdomain .context.Values.domain }}
  {{- end -}}
{{- end -}}