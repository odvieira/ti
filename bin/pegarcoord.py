#!/usr/bin/env python3
import requests
import time

lines = []
with open("TabelaCoord.csv", "w", encoding="latin-1") as out:
    with open("Tabela.csv", "r", encoding="latin-1") as arq:
        out.write(arq.readline()[:-1]+";\"nelat\";\"nelng\";\"swlat\";\"swlng\";\"plat\";\"plng\""+"\n")

        lin = arq.readline()[:-1]   
        timestart = time.time() 
        errcnt = 0
        cur = 0
        try:
            while cur<1280:
                cep = lin.split(";")[6].replace("\"", "")
                cep = cep[:5]+"-"+cep[5:]
                resp = requests.get("https://maps.googleapis.com/maps/api/geocode/json?address="+cep
                                    +"&key=AIzaSyDMDKSw4pD6Gbc4vwij9GLuMaKhPZIH1uo")
                json = resp.json()
                try:
                    geometry = json["results"][0]["geometry"]
                    nlng = json["results"][0]["geometry"]["bounds"]["northeast"]["lng"]
                    nlat = json["results"][0]["geometry"]["bounds"]["northeast"]["lat"]
                    slng = json["results"][0]["geometry"]["bounds"]["southwest"]["lng"]
                    slat = json["results"][0]["geometry"]["bounds"]["southwest"]["lat"]
                    plng = json["results"][0]["geometry"]["location"]["lng"]
                    plat = json["results"][0]["geometry"]["location"]["lat"]
                    curline = (lin+";\""+str(nlat)+"\";\""+str(nlng)
                                +"\";\""+str(slat)+"\";\""+str(slng)+"\";\""
                                +str(plat)+"\";\""+str(plng)+"\"")
                    out.write(curline+"\n")
                    
                    print("CEP "+cep+" done. Error count:"+str(errcnt)+" Progress:"+str((cur*100)/1280) + "%" )
                    cur+=1
                except:
                    print("CEP "+cep+" done WITH ERROR. Error count:"+str(errcnt)+" Progress:"+str((cur*100)/1280) + "%")
                    cur+=1
                    errcnt += 1
                lin = arq.readline()[:-1]
        except KeyboardInterrupt:
            print(str(time.time()-timestart)) 
            quit()
