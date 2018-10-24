#!/bin/sh
PROC="/opt/processing-3.4/processing-java"
./draw/draw_java/load_curitiba.sh
${PROC} --sketch=./draw/draw_java --run
${PROC} --sketch=./draw/show_java --run
