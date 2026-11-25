.PHONY: lint breaking gen check release

lint:
	buf lint

RETRACTED := $(shell awk '/^retract[ \t]*\(/{b=1;next} b&&/^\)/{b=0} b{print $$1} /^retract[ \t]+v/{print $$2}' go.mod)

breaking:
	@tag=$$(git describe --tags --abbrev=0 $(foreach t,$(RETRACTED),--exclude $(t)) 2>/dev/null); \
	if [ -n "$$tag" ]; then buf breaking --against ".git#tag=$$tag"; else echo "no release tag yet, nothing to compare against"; fi

gen:
	buf generate

check: lint breaking gen
	@test -z "$$(git status --porcelain gen)" || (git status --porcelain gen && echo "gen/ is out of date or untracked" && exit 1)

release: check
	@test -n "$(VERSION)" || (echo "usage: make release VERSION=vX.Y.Z" && exit 1)
	@echo "$(VERSION)" | grep -Eq '^v[0-9]+\.[0-9]+\.[0-9]+$$' || (echo "VERSION must look like v1.2.3" && exit 1)
	@test -z "$$(git status --porcelain)" || (echo "working tree is not clean" && exit 1)
	git tag -a $(VERSION) -m "$(VERSION)"
	@echo "tag $(VERSION) created locally; push it explicitly: git push origin $(VERSION)"
