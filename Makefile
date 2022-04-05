PACKAGE=api
TEST=tests
BLUE='\033[0;34m'

all: run

sort: 
	@echo "\n${BLUE} Running isort..."
	@isort .

lint: sort
	@echo "\n${BLUE} Running the flake8 linter..."
	@flake8
	@echo "\n${BLUE} Running the pylint linter..."
	@pylint --rcfile=setup.cfg api/

test: lint
	@echo "\n${BLUE} Running the tests..."
	@SECRET_KEY=secret_key FLASK_ENV=development venv/bin/python3 -m  pytest

install: requirements.txt 
	@pip install -r requirements.txt

install-dev: requirements-dev.txt
	@pip install -r requirements-dev.txt

run: 
	@echo SECRET_KEY=secret_key"\n"FLASK_ENV=development"\n"APP=app.py"\n" > .env 
	@flask run

clean:
	@rm -rf .pytest_cache .coverage coverage.xml __pycache__ ${PACKAGE}/__pycache__ ${TEST}/__pycache__ 