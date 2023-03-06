ANSIBLE=ansible -i inventory/inventory.yaml
RASPBERRY_HOST=192.168.178.10
KEEPASS_CLI=/Applications/KeePassXC.app/Contents/MacOS/keepassxc-cli

install-ssh-key:
	ssh-copy-id -i ~/.ssh/id_rsa.pub growlab@$(RASPBERRY_HOST)

verify-conncetion:
	$(ANSIBLE) all -m ping

PHONY=install-ssh-key
