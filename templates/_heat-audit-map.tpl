{{- define "heat-audit-map" }}
[DEFAULT]
# default target endpoint type
# should match the endpoint type defined in service catalog
target_endpoint_type = None

# possible end path of api requests
[path_keywords]
stacks = stack
resources = resource
preview = None
detail = None
abandon = None
snapshots = snapshot
restore = None
outputs = output
metadata = server
signal = None
events = event
template = None
template_versions = template_version
functions = None
validate = None
resource_types = resource_type
build_info = None
actions = None
software_configs = software_config
software_deployments = software_deployment
services = None

# map endpoint type defined in service catalog to CADF typeURI
[service_endpoints]
orchestration = service/orchestration
{{- end }}
