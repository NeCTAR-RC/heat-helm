{{- define "heat-conf" }}
[DEFAULT]
stack_domain_admin=heat_stack_admin
stack_user_domain_name=heat
region_name_for_services={{ .Values.conf.region_name_for_services }}
enable_stack_abandon={{ .Values.conf.enable_stack_abandon }}
enable_stack_adopt={{ .Values.conf.enable_stack_adopt }}
debug={{ .Values.conf.debug }}

[trustee]
auth_type=password
auth_url={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
user_domain_name=Default

[ec2authtoken]
auth_uri={{ .Values.conf.keystone.auth_url }}

[heat_api_cfn]
bind_port={{ .Values.api_cfn.port }}

[heat_api]
bind_port={{ .Values.api.port }}

[audit_middleware_notifications]
driver=log

[database]
connection={{ .Values.conf.database_connection }}

[keystone_authtoken]
auth_url={{ .Values.conf.keystone.auth_url }}
www_authenticate_uri={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password
{{- if .Values.conf.keystone.memcache_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}
service_type=orchestration

[oslo_messaging_rabbit]
amqp_durable_queues=True
heartbeat_timeout_threshold=60
ssl=True
ssl_version=TLSv1_2

[oslo_middleware]
enable_proxy_headers_parsing=True

[oslo_policy]
policy_file=/etc/heat/policy.yaml
{{- end }}
