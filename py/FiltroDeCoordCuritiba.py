#!/usr/bin/env python3

table = []
with open("TabelaCoord.csv", "r") as rtbl:
    header = rtbl.readline() #remove header
    
    for line in rtbl:
        table.append(line)
   
tablenew = []   
for k, v in enumerate(table):
    split = v.strip().split(";")
    lat = float(split[12][:-1][1:])
    lng = float(split[13][:-1][1:])
    if (lat < -25.346814 and lat > -25.645500 and lng > -49.389163 and lng < -49.185324):
        tablenew.append(v)
print(len(table))     
print(len(tablenew))

with open("TabelaCoordFiltrada.csv", "w") as wtbl:
    wtbl.write(header)
    
    for i in tablenew:
        wtbl.write(i)
    
    print("Done")