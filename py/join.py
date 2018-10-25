#!/usr/bin/env python3

def appendcurso(filename):
    lines = []
    with open(filename, "r", encoding="latin-1") as arq:
        lines.append(arq.readline()[:-1]+";\"Curso\"")
        l = arq.readline()[:-1]
        while l != "":
            lines.append(l+";\""+filename[:-4]+"\"")
            l = arq.readline()[:-1]

    with open(filename, "w", encoding="latin-1") as arq:
        for i in lines:
            arq.write(i+"\n")
    return filename

def joincsv(ffile, sfile):
    lines = []
    with open(ffile, "r", encoding="latin-1") as arq:
        lines.append(arq.readline()[:-1])
        l = arq.readline()[:-1]
        while l != "":
            lines.append(l)
            l = arq.readline()[:-1]

    with open(sfile, "r", encoding="latin-1") as arq:
        arq.readline()
        l = arq.readline()[:-1]
        while l != "":
            lines.append(l)
            l = arq.readline()[:-1]

    filename = ffile[:-4]+sfile[:-4]+".csv"
    with open(filename, "w", encoding="latin-1") as arq:
        for i in lines:
            arq.write(i+"\n")
    return filename

adm = appendcurso("ADM.csv")
bsi = appendcurso("BSI.csv")
des = appendcurso("DESIGN.csv")
eng = appendcurso("ENGCOMP.csv")
licf = appendcurso("LICFISICA.csv")

first = joincsv(adm, bsi)
sec = joincsv(first, des)
third = joincsv(sec, eng)
joincsv(third, licf)
        
        
