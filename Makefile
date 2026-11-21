.PHONY: lint breaking gen check release

lint:
	buf lint

breaking:
	buf breaking --against '.git#branch=main'

gen:
	buf generate

check: lint breaking gen
	git diff --exit-code -- gen

release: check
	@test -n "$(VERSION)" || (echo "usage: make release VERSION=vX.Y.Z" && exit 1)
	@echo "$(VERSION)" | grep -Eq '^v[0-9]+\.[0-9]+\.[0-9]+$$' || (echo "VERSION must look like v1.2.3" && exit 1)
	@test -z "$$(git status --porcelain)" || (echo "working tree is not clean" && exit 1)
	git tag -a $(VERSION) -m "$(VERSION)"
	@echo "tag $(VERSION) created locally; push it explicitly: git push origin $(VERSION)"
