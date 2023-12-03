VENV_NAME := venv

# Warn users that these commands are meant for Windows systems
ifeq ($(OS),Windows_NT)
    WARNING_MESSAGE :=
else
    WARNING_MESSAGE := @echo "WARNING: These commands are meant to be used on Windows systems."
endif

.PHONY: setup update clean help run-jupyter

# Add a default target to print a helpful message
.DEFAULT_GOAL := help

init:
	@if not exist data\raw mkdir data\raw
	@if not exist data\processed mkdir data\processed
	@if not exist data\external mkdir data\external
	@if not exist notebooks mkdir notebooks
	@if not exist docs mkdir docs
	@echo ">>>>>> Project structure initialized successfully <<<<<<"
	@echo "Placeholder content" > README.md
	@echo "author: labriji saad" > config.yaml
	@echo "# Add your environment variables here" > .env
	@echo "# Add files and directories to ignore in version control" > .gitignore
	@echo "# Add your project dependencies here" > requirements.txt

setup:
	$(WARNING_MESSAGE)
	@python -m venv $(VENV_NAME) && \
	$(VENV_NAME)\Scripts\activate && \
	powershell -Command "& {python -m pip install --upgrade pip; pip install -r requirements.txt}" 
	@echo ">>>>>> Environment is ready <<<<<<"

update:
	$(VENV_NAME)\Scripts\activate && pip install -r .\requirements.txt
	@echo ">>>>>> Dependencies updated <<<<<<"

clean:
	$(WARNING_MESSAGE)
	@rmdir /s /q $(VENV_NAME)
	@echo ">>>>>> Cleaned up environment <<<<<<"

jupyter:
	$(WARNING_MESSAGE)
	@$(VENV_NAME)\Scripts\activate && jupyter lab
	@echo ">>>>>> Jupyter Lab is running <<<<<<"

help:
	$(WARNING_MESSAGE)
	@echo "Available targets:"
	@echo "  make init           - Initialize The project's structure"
	@echo "  make setup          - Create a virtual environment and install dependencies"
	@echo "  make update         - Update dependencies in the virtual environment"
	@echo "  make clean          - Clean up the virtual environment and generated files"
	@echo "  make jupyter    - Activate the virtual environment and run Jupyter Lab"