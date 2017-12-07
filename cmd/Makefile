all: apply

apply:
	terraform apply -var "admin_ssh_key=$$admin_ssh_key" -var "public_domain=$$public_domain"

destroy:
	terraform destroy -var "admin_ssh_key=$$admin_ssh_key" -var "public_domain=$$public_domain"

.PHONY: clean all