#!/bin/bash

perl industriesCaillasse.pl > industriesCaillasse.csv
perl countriesCaillasse.pl > countriesCaillasse.csv
python3 companiesCaillasse.py > companiesCaillasse.csv
perl post.pl companiesCaillasse.csv
