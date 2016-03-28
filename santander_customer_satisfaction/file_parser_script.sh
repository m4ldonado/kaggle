#!/bin/bash
# Combines the training and test data, uses the file_parser script on the result and splits the training and test data again.  
# Creates combined.csv newtrain.csv and newtest.csv

cp train.csv combined.csv
sed -n '2,$p' test.csv >> combined.csv
perl file_parser.pl combined.csv > newcombined.csv
i=$(wc -l < train.csv)
sed -n "1 , $i p" newcombined.csv > newtrain.csv
i=$((i + 1))
sed -n '1p' test.csv > newtest.csv
sed -n "$i , $ p" newcombined.csv >> newtest.csv
