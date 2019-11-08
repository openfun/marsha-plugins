BOLD := \033[1m
RESET := \033[0m

default: help

env.d/development:
	cp env.d/development.dist env.d/development

state-create: ## Create the shared state bucket
state-create: env.d/development
	@bin/state init
	@bin/state apply
.PHONY: state-create

init: ## Initialize terraform project
init: env.d/development
	@bin/terraform init
.PHONY: init

deploy: ## Create or complete the AWS infra and copy files to the S3 bucket
	@bin/terraform apply
.PHONY: deploy

help:  ## Show this help
	@echo "$(BOLD)Marsha plugins Makefile$(RESET)"
	@echo "Please use 'make $(BOLD)target$(RESET)' where $(BOLD)target$(RESET) is one of:"
	@grep -h ':\s\+##' Makefile | column -tn -s# | awk -F ":" '{ print "  $(BOLD)" $$1 "$(RESET)" $$2 }'
.PHONY: help
