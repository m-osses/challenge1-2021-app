.PHONY: help
.ONESHELL:

# For use of bash, to be able to "source" virtualenv's "activate" script
SHELL = /bin/bash

VIRTUALENV_DIR := .virtualenv

help:
	@echo "See the sources"


virtualenv-update:
	set -e
	test -d $(VIRTUALENV_DIR) || virtualenv --seeder pip -p python3.7 $(VIRTUALENV_DIR)
	source $(VIRTUALENV_DIR)/bin/activate
	pip install pip-tools

pip-compile:
	set -ex
	source $(VIRTUALENV_DIR)/bin/activate
	CUSTOM_COMPILE_COMMAND="make pip-compile-sync" pip-compile $(PIP_COMPILE_CUSTOM_ARGS) --generate-hashes --output-file ./reqs/requirements-prod.txt  ./reqs/requirements-prod.in
	CUSTOM_COMPILE_COMMAND="make pip-compile-sync" pip-compile $(PIP_COMPILE_CUSTOM_ARGS) --generate-hashes --output-file ./reqs/requirements-ci.txt	./reqs/requirements-ci.in

pip-compile-upgrade:
	$(MAKE) PIP_COMPILE_CUSTOM_ARGS="--upgrade" pip-compile

pip-sync:
	set -e
	source $(VIRTUALENV_DIR)/bin/activate
	pip-sync --pip-args "--no-deps --require-hashes" ./reqs/requirements-ci.txt

pip-run-safety:
	set -e
	source $(VIRTUALENV_DIR)/bin/activate
	pip freeze > reqs.txt
	safety check -r reqs.txt

database-docker-compose-up-d:
	set -e
	source $(VIRTUALENV_DIR)/bin/activate
	docker-compose -f docker-compose.yml up -d

env-local-export: envs/local/.env.local
	sed -ne '/^export / {p;d}; /.*=/ s/^/export / p' envs/local/.env.local > env-local-export

flask_run: env-local-export
	set -e
	source $(VIRTUALENV_DIR)/bin/activate
	export FLASK_APP=app.py
	. env-local-export && flask run
