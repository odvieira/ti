#!/bin/sh
echo "Loading environment variables..."

export PROC="/usr/local/programas/processing-3.3"
export HM_SCR_SCALE="0.36"
export HM_SCR_W="445"
export HM_SCR_H="705"
export HM_OUT="output.png"
export HM_MIN_LAT="-25.645500"
export HM_MAX_LAT="-25.346814"
export HM_MIN_LON="-49.389163"
export HM_MAX_LON="-49.185324"
export HM_MAP="./temp/map.svg"
export HM_TABLE="./temp/table.csv"
export HM_TABLE_OPT="header, csv"

echo "Loading files..."
MAP="./data/curitiba/svg/curitiba_label.svg"
TABLE="./data/curitiba/coord.csv"
LIMITS="./data/curitiba/limits"

cp ${MAP} ./Designer/temp/map.svg
cp ${TABLE} ./Designer/temp/table.csv
cp ${LIMITS} ./Designer/temp/limits


echo "Generating heat map..."
${PROC}/processing-java --sketch=./Designer --run

echo "Loading heat map..."
cp ./Designer/${HM_OUT} ./Viewer/${HM_OUT}
if [ -d Results ]
	then
			mv ./Designer/${HM_OUT} ./Results
	else
		mkdir Results
		mv ./Designer/${HM_OUT} ./Results
fi

echo "Reading heat map..."
${PROC}/processing-java --sketch=./Viewer --run

echo "Exiting..."
rm -rf ./Viewer/${HM_OUT}
