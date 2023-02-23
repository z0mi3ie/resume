RESUME_FILE := resume.tex
BUILD_DIR := build
OUTPUT_JOB := kyle-vickers-resume
OUTPUT_FMT := pdf
VERSION := 0.0.1
TIMESTAMP := $(shell date +%s)
TAG := v${VERSION}-${TIMESTAMP}
BRANCH := main

.PHONY: build/docker
build/docker:
	docker run \
		--rm \
		--interactive \
		--user="$(id -u):$(id -g)" \
		--volume ${PWD}:/data \
		blang/latex \
		make build

.PHONY: build
build: clean
	mkdir build
	pdflatex \
		-jobname=${OUTPUT_JOB} \
		-output-directory=${BUILD_DIR} \
		-output-format=${OUTPUT_FMT} \
		${RESUME_FILE}

.PHONY: open
open: build
	open ${BUILD_DIR}/${OUTPUT_JOB}.${OUTPUT_FMT}

.PHONY: tag
tag:
	git tag ${TAG}

.PHONY: release
release: tag
	git push -u origin ${BRANCH}
	git push -u origin ${TAG}

.PHONY: clean
clean:
	rm -rf *.out
	rm -rf *.pdf
	rm -rf *.aux
	rm -rf *.log
	rm -rf build
