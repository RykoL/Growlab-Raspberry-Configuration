export TF_VAR_raspberry_public_ip="192.168.178.1"
export TF_VAR_raspberry_public_cidr="24"


init:
	terraform init -reconfigure

plan:
	terraform plan

apply:
	$(MAKE) -C ../api clean
	rm image-upload-api.zip || true
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve

format:
	terraform fmt
