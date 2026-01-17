install:
	poetry install --with=dev
.PHONY: install

lint:
	poetry run isort src/
	poetry run black src/
	poetry run flake8 src/
.PHONY: lint

clean:
	poetry env remove
.PHONY: clean
