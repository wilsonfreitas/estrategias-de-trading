#!/usr/bin/env Rscript

suppressMessages(library('slidify'))

argv <- commandArgs(TRUE)

for (filename in argv) {
    cat(filename, '\n')
    output = suppressMessages(slidify(filename))
    cat(output, '\n')
}


