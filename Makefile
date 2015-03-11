all: prepare test

prepare:
	cpanm --quiet --installdeps --notest .

test:
	t/test.sh

.PHONY: test
