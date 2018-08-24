#!/bin/sh

convert coltest-ycbcr601.png coltest-ycbcr709.png -append coltest1.png
convert coltest-ycbcr2020.png coltest-ycocg.png -append coltest2.png
convert coltest1.png coltest2.png +append coltest.png

rm coltest1.png
rm coltest2.png

