#!/bin/sh
mongoimport --db=Lab4 --collection=main --type=csv --fields=URL,IP,timeStamp,timeSpent --file=log.csv
