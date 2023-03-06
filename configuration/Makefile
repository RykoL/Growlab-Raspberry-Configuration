ANSIBLE=ansible -i inventory/inventory.yaml
ANSIBLE_PLAYBOOK=ansible-playbook -i inventory/inventory.yaml
RASPBERRY_HOST=192.168.178.10

install-ssh-key:
	ssh-copy-id -i ~/.ssh/id_rsa.pub growlab@$(RASPBERRY_HOST)

verify-connection:
	$(ANSIBLE) all -m ping

apply-configuration:
	$(ANSIBLE_PLAYBOOK) -K playbook.yaml

open-vlc:
	vlc http://$(RASPBERRY_HOST):8099

PHONY=install-ssh-key verify-connection open-vlc
