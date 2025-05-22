up:
	vagrant up

down:
	vagrant halt

halt:
	vagrant halt

destroy:
	rm -rf key key.pub
	vagrant destroy

install:
	brew tap hashicorp/tap
	brew install hashicorp/tap/vagrant

.PHONY: up down halt destroy install