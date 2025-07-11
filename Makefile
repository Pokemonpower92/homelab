.PHONY: setup install-deps encrypt-secrets decrypt-secrets cluster arc destroy status help

setup: install-deps cluster arc argocd

install-deps:
	ansible-galaxy install -r ansible/requirements.yml

encrypt-secrets:
	ansible-vault encrypt --vault-password-file .vault_password ansible/inventory/group_vars/all/vault.yml

decrypt-secrets:
	ansible-vault decrypt --vault-password-file .vault_password ansible/inventory/group_vars/all/vault.yml

cluster:
	cd ansible && ansible-playbook -i inventory/hosts.yml playbooks/k3s-cluster.yml --vault-password-file ../.vault_password --ask-become-pass

arc:
	cd ansible && ansible-playbook -i inventory/hosts.yml playbooks/arc.yml --vault-password-file ../.vault_password --ask-become-pass
	
argocd:
	cd ansible && ansible-playbook -i inventory/hosts.yml playbooks/argocd.yml --vault-password-file ../.vault_password --ask-become-pass

argo-workflow:
	cd ansible && ansible-playbook -i inventory/hosts.yml playbooks/argo-workflow.yml --vault-password-file ../.vault_password --ask-become-pass

destroy:
	cd ansible && ansible-playbook -i inventory/hosts.yml playbooks/destroy.yml --vault-password-file ../.vault_password --ask-become-pass

status:
	kubectl get nodes
	kubectl get pods -A
	kubectl get runners -n actions-runner-system
	kubectl get horizontalrunnerautoscalers -n actions-runner-system

help:
	@echo "Available commands:"
	@echo "  setup          - Install deps, create cluster, install ARC"
	@echo "  cluster        - Setup K3s cluster only"
	@echo "  arc            - Install Official Actions Runner Controller"
	@echo "  destroy        - Destroy the entire cluster"
	@echo "  status         - Show cluster and runner status"
	@echo "  encrypt-secrets - Encrypt vault.yml file"
	@echo "  decrypt-secrets - Decrypt vault.yml for editing"
	@echo ""
	@echo "First time setup:"
	@echo "  1. Create ansible/group_vars/all/vault.yml with your GitHub PAT:"
	@echo "     github_pat: 'ghp_your_token_here'"
	@echo "  2. Run: make encrypt-secrets"
	@echo "  3. Run: make setup"
	@echo ""
	@echo "In your workflows, use:"
	@echo "  runs-on: [self-hosted, k3s, pixels]"