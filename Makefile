.PHONY: lint-fix

lint-fix:
	npx markdownlint-cli2 --fix "**/*.md"
