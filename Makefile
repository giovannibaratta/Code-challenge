.SILENT:
.PHONY: clean clean_python_venv clean_terraform_linter create_fresh_python_venv create_python_venv lint_ansible lint_terraform

ANSIBLE_FILES := $(shell find ansible/ -name '*.yml' )
# Percorso in cui creare l'environment python virtuale
VIRTUAL_ENV_DIR := .virtual_env/

# Crea l'ambiente virtuale e installa i pacchetti python
$(VIRTUAL_ENV_DIR):
	echo "Creating python virtual environment ..."
	python3 -m venv $(VIRTUAL_ENV_DIR)
	( \
		. $(VIRTUAL_ENV_DIR)/bin/activate; \
		pip install -r requirments.txt; \
	)

# Renaiming del comando
create_python_venv: $(VIRTUAL_ENV_DIR)

# Ricrea l'ambiente virtuale e install i pacchetti python
create_fresh_python_venv: clean_python_venv $(VIRTUAL_ENV_DIR)

# Scarica e installa il linter di terraform
tmp/tflint:
	( \
		mkdir -p tmp; \
		cd tmp; \
		curl -L "$(shell curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip; \
		unzip -o tflint.zip; \
		rm tflint.zip; \
	)

# Renaiming del comando
install_terraform_linter: tmp/tflint

lint_ansible: create_python_venv
	( \
		. $(VIRTUAL_ENV_DIR)/bin/activate; \
		ansible-lint $(ANSIBLE_FILES) \
	)

lint_terraform: install_terraform_linter
	( \
		cd tmp; \
		./tflint ../terraform; \
	)

clean_terraform_linter:
	rm -rf tmp

clean_python_venv:
	rm -rf $(VIRTUAL_ENV_DIR)

clean: clean_terraform_linter clean_python_venv
install: create_fresh_python_venv install_terraform_linter
lint: lint_ansible lint_terraform
all: clean install lint