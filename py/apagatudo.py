#!/usr/bin/env python3

with open("filename.csv","r") as rcsv:
	with open("certo.csv","a") as wccsv:
		with open("errado.csv","w") as wecsv:
			for line in rcsv:
				array = line.split(",")
				if (int(array[2])>20 or int(array[3])>20):
					wccsv.write(",".join(array))
				else:
					wecsv.write(",".join(array))
