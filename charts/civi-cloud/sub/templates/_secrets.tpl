{{/*
Returns a value from the SSO secret given a key
Usage:
{{ include "get_sso_config" (dict "key" "key-name" "context" $) }}

Params:
  - key - String - Required - Key of the value to retrieve.
  - context - Context - Required - Parent context.
*/}}
{{- define "get_sso_config" -}}
  {{- $secret := (lookup "v1" "Secret" .context.Values.sso.namespace .context.Values.sso.secretName) }}
  {{- if $secret }}
    {{- if hasKey $secret.data .key }}
      {{- index $secret.data .key | b64dec -}}
    {{- else }}
      {{- printf "\nERROR: The SSO secret does not contain the key \"%s\"\n" .key | fail -}}
    {{- end -}}
  {{- else }}
    {{- printf "\nERROR: secret \"%s\" does not exist in namespace \"%s\"\n" .context.Values.sso.secretName .context.Values.sso.namespace | fail -}}
  {{- end -}}
{{- end -}}
