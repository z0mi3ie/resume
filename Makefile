RESUME_FILE := resume.tex
BUILD_DIR := build
OUTPUT_JOB := kyle-vickers-resume
OUTPUT_FMT := pdf

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

.PHONY: clean
clean:
	rm -rf *.out
	rm -rf *.pdf
	rm -rf *.aux
	rm -rf *.log
	rm -rf build
