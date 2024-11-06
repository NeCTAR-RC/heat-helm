{{- define "heat-api-paste" }}
[pipeline:heat-api]
pipeline = healthcheck cors request_id faultwrap http_proxy_to_wsgi versionnegotiation osprofiler authurl authtoken context audit apiv1app

[pipeline:heat-api-standalone]
pipeline = healthcheck cors request_id faultwrap http_proxy_to_wsgi versionnegotiation authurl authpassword context apiv1app

[pipeline:heat-api-custombackend]
pipeline = healthcheck cors request_id faultwrap versionnegotiation context custombackendauth apiv1app

[pipeline:heat-api-noauth]
pipeline = healthcheck cors request_id faultwrap http_proxy_to_wsgi versionnegotiation noauth context apiv1app

[pipeline:heat-api-cfn]
pipeline = healthcheck cors request_id http_proxy_to_wsgi cfnversionnegotiation osprofiler ec2authtoken authtoken context audit apicfnv1app

[pipeline:heat-api-cfn-standalone]
pipeline = healthcheck cors request_id http_proxy_to_wsgi cfnversionnegotiation ec2authtoken context apicfnv1app

[app:apiv1app]
paste.app_factory = heat.common.wsgi:app_factory
heat.app_factory = heat.api.openstack.v1:API

[app:apicfnv1app]
paste.app_factory = heat.common.wsgi:app_factory
heat.app_factory = heat.api.cfn.v1:API

[filter:versionnegotiation]
paste.filter_factory = heat.common.wsgi:filter_factory
heat.filter_factory = heat.api.openstack:version_negotiation_filter

[filter:cors]
paste.filter_factory = oslo_middleware.cors:filter_factory
oslo_config_project = heat

[filter:faultwrap]
paste.filter_factory = heat.common.wsgi:filter_factory
heat.filter_factory = heat.api.openstack:faultwrap_filter

[filter:cfnversionnegotiation]
paste.filter_factory = heat.common.wsgi:filter_factory
heat.filter_factory = heat.api.cfn:version_negotiation_filter

[filter:cwversionnegotiation]
paste.filter_factory = heat.common.wsgi:filter_factory

[filter:context]
paste.filter_factory = heat.common.context:ContextMiddleware_filter_factory

[filter:ec2authtoken]
paste.filter_factory = heat.api.aws.ec2token:EC2Token_filter_factory

[filter:http_proxy_to_wsgi]
paste.filter_factory = oslo_middleware:HTTPProxyToWSGI.factory

[filter:authurl]
paste.filter_factory = heat.common.auth_url:filter_factory

[filter:authtoken]
paste.filter_factory = keystonemiddleware.auth_token:filter_factory

[filter:authpassword]
paste.filter_factory = heat.common.auth_password:filter_factory

[filter:custombackendauth]
paste.filter_factory = heat.common.custom_backend_auth:filter_factory

[filter:noauth]
paste.filter_factory = heat.common.noauth:filter_factory

[filter:request_id]
paste.filter_factory = oslo_middleware.request_id:RequestId.factory

[filter:osprofiler]
paste.filter_factory = osprofiler.web:WsgiMiddleware.factory

[filter:healthcheck]
disable_by_file_path=/etc/heat/healthcheck_disable
paste.filter_factory=oslo_middleware:Healthcheck.factory
backends=disable_by_file
path=/healthcheck

[filter:audit]
paste.filter_factory = keystonemiddleware.audit:filter_factory
audit_map_file = /etc/heat/api_audit_map.conf
ignore_req_list = GET
{{- end }}
