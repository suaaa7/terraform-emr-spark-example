.PHONY: plan
plan:
	terraform plan \
		-var cluster_name=$${CLUSTER_NAME}

.PHONY: apply
apply:
	terraform apply \
		-var cluster_name=$${CLUSTER_NAME}

.PHONY: destroy
destroy:
	terraform destroy \
		-var cluster_name=$${CLUSTER_NAME}

.PHONY: reset
reset:
	git reset modules/bootstrap/templates/shiro.ini.tpl
