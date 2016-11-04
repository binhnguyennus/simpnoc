#!/bin/bash

mkdir -p {build,output}

OUT="build/a.out"

iverilog -I src -I gen -o $OUT src/testbench.v && vvp $OUT
