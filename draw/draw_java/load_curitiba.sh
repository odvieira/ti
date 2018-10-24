#!/bin/sh
echo "Loading files..."

MAP="../../data/curitiba/svg/curitiba_label.svg"
TABLE="../../data/curitiba/coord.csv"
LIMITS="../../data/curitiba/limits"

cp ${MAP} ./temp/map.svg
cp ${TABLE} ./temp/table.csv
cp ${LIMITS} ./temp/limits
