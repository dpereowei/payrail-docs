SHELL := /bin/sh

COMPOSE ?= docker compose
TERRAFORM ?= terraform
TF_DIR := infra

.PHONY: help local-up local-down local-logs local-ps terraform-init terraform-fmt terraform-validate terraform-plan terraform-apply terraform-destroy terraform-output

help:
	@printf '%s\n' 'PayRail local commands'
	@printf '%s\n' ''
	@printf '%s\n' 'Local services:'
	@printf '%s\n' '  make local-up          Start LocalStack and Postgres'
	@printf '%s\n' '  make local-down        Stop local services'
	@printf '%s\n' '  make local-logs        Follow local service logs'
	@printf '%s\n' '  make local-ps          Show local service status'
	@printf '%s\n' ''
	@printf '%s\n' 'Terraform:'
	@printf '%s\n' '  make terraform-init    Initialize Terraform without remote backend'
	@printf '%s\n' '  make terraform-fmt     Format Terraform files'
	@printf '%s\n' '  make terraform-validate Validate Terraform configuration'
	@printf '%s\n' '  make terraform-plan    Plan against LocalStack'
	@printf '%s\n' '  make terraform-apply   Apply against LocalStack'
	@printf '%s\n' '  make terraform-destroy Destroy LocalStack-managed resources'
	@printf '%s\n' '  make terraform-output  Show Terraform outputs'

local-up:
	$(COMPOSE) up -d

local-down:
	$(COMPOSE) down

local-logs:
	$(COMPOSE) logs -f

local-ps:
	$(COMPOSE) ps

terraform-init:
	cd $(TF_DIR) && $(TERRAFORM) init -backend=false

terraform-fmt:
	cd $(TF_DIR) && $(TERRAFORM) fmt -recursive

terraform-validate:
	cd $(TF_DIR) && $(TERRAFORM) validate

terraform-plan:
	cd $(TF_DIR) && $(TERRAFORM) plan

terraform-apply:
	cd $(TF_DIR) && $(TERRAFORM) apply

terraform-destroy:
	cd $(TF_DIR) && $(TERRAFORM) destroy

terraform-output:
	cd $(TF_DIR) && $(TERRAFORM) output
