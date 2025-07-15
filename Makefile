.DEFAULT_GOAL := help 

# Detectar el sistema operativo
ifeq ($(OS),Windows_NT)
    DETECTED_OS := Windows
    SHELL_EXEC := powershell -ExecutionPolicy Bypass -File
    ENV_SET := set
    PATH_SEP := &&
else
    DETECTED_OS := Linux
    SHELL_EXEC := bash
    ENV_SET := export
    PATH_SEP := ;
endif

.PHONY: help
help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

pre-requirements:
ifeq ($(DETECTED_OS),Windows)
	@$(SHELL_EXEC) scripts/pre-requirements.ps1
else
	@bash scripts/pre-requirements.sh
endif

.PHONY: local-setup
local-setup: pre-requirements ## Sets up the local environment (e.g. install git hooks)
ifeq ($(DETECTED_OS),Windows)
	$(SHELL_EXEC) scripts/local-setup.ps1
else
	bash scripts/local-setup.sh
endif
	make install

.PHONY: install
install: pre-requirements ## Install the app packages
	uv python install 3.12.8
	uv python pin 3.12.8
	uv sync --no-install-project

.PHONY: update
update: pre-requirements ## Updates the app packages
	uv lock --upgrade

.PHONY: add-dev-package
add-dev-package: pre-requirements ## Installs a new package in the app. ex: make add-dev-package package=XXX
	uv add --dev $(package)

.PHONY: add-package
add-package: pre-requirements ## Installs a new package in the app. ex: make add-package package=XXX
	uv add $(package)

.PHONY: run
run: pre-requirements ## Runs the app
	python main.py

.PHONY: check-typing
check-typing: pre-requirements  ## Run a static analyzer over the code to find issues
	ty check .

.PHONY: check-lint
check-lint: pre-requirements ## Checks the code style
	ruff check

.PHONY: lint
lint: pre-requirements ## Lints the code format
	ruff check --fix

.PHONY: check-format
check-format: pre-requirements  ## Check format python code
	ruff format --check

.PHONY: format
format: pre-requirements  ## Format python code
	ruff format

.PHONY: checks
checks: pre-requirements check-lint check-format check-typing  ## Run all checks

.PHONY: test
test: pre-requirements ## Run all the tests
ifeq ($(DETECTED_OS),Windows)
	$(ENV_SET) PYTHONPATH=. $(PATH_SEP) pytest tests -ra -x --durations=5
else
	PYTHONPATH=. pytest tests -ra -x --durations=5
endif

.PHONY: watch
watch: pre-requirements ## Run all the tests in watch mode
ifeq ($(DETECTED_OS),Windows)
	$(ENV_SET) PYTHONPATH=. $(PATH_SEP) ptw --runner "pytest tests -ra -x --durations=5"
else
	PYTHONPATH=. ptw --runner "pytest tests -ra -x --durations=5"
endif

.PHONY: pre-commit
pre-commit: pre-requirements check-format check-typing check-lint test
	
.PHONY: rename-project
rename-project: ## Rename project make rename name=new-name
ifeq ($(DETECTED_OS),Windows)
	powershell -Command "(Get-Content Makefile) -replace 'python-boilerplate', '$(name)' | Set-Content Makefile"
	powershell -Command "(Get-Content pyproject.toml) -replace 'python-boilerplate', '$(name)' | Set-Content pyproject.toml"
else
	sed -i 's/python-boilerplate/$(name)/' Makefile
	sed -i 's/python-boilerplate/$(name)/' pyproject.toml
endif
