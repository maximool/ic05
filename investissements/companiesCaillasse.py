#!/usr/bin/python


# En-tête
import collections
import csv
import re

# Corps du script
entANDmoney = {}
with open ("realEntreprises.csv") as ei :
    EIcsvReader = csv.reader(ei,delimiter=',',quotechar='"')
    for EIrow in EIcsvReader :
        ent = EIrow[0]
        entANDmoney[ent] = 0.0
        with open ("luxleakscorrectednoheader.csv") as ll :
            LLcsvReader = csv.reader(ll,delimiter=',',quotechar='|')
            for LLrow in LLcsvReader :
                tmpent = LLrow[1]
                tmpinv = LLrow[7]
                if (ent == tmpent) :
                    elements = tmpinv.split(' ')
                    i = 0
                    total = 0
                    while (i < len(elements)) :
                        re.sub("\"Dawnay", "Dawnay", elements[i])
                        if (re.match("\\d+(\.\\d*)?", elements[i])) :
                            elements[i] = elements [i]
                            if (LLrow[8] == "USD") :
                                elements[i] = float(elements[i]) * 0.886
                            elif (LLrow[8] == "EUR") :
                                elements[i] = float(elements[i]) * 1.0
                            elif (LLrow[8] == "GBP") :
                                elements[i] = float(elements[i]) * 1.36
                        elif (elements[i] == "billion") :
                            elements[i-1] = float(elements[i-1]) * 1000000000.0
                            elements[i] = ""
                        elif (elements[i] == "million") :
                            elements[i-1] = float(elements[i-1]) * 1000000.0
                            elements[i] = ""
                        else :
                            elements[i] = ""
                        i += 1
                    i = 0
                    while (i < len(elements)) :
                        if (elements[i] != "") :
                            total += float(elements[i])
                        i += 1
                    entANDmoney[ent] += total
od = collections.OrderedDict(sorted(entANDmoney.items()))
#for key, value in entANDmoney.items() :
for key, value in od.items() :
    print(key, ",", value)
