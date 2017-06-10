#!/bin/bash

rm ./*.txt

fromPrice=500
toPrice=80000
fromYear=1990
toYear=2017
fromLength=34
toLength=40
man='tartan%2Ccatalina%2Ccabo+rico%2Cmason%2Ccape+dory%2Cnajad%2Cpacket'

toGet='http://www.yachtworld.com/core/listing/cache/searchResults.jsp?toPrice='$toPrice'&Ntk=boatsEN&type=%28Sail%29&fromYear='$fromYear'&searchtype=advancedsearch&hmid=102&sm=3&enid=100&toYear='$toYear'&luom=126&currencyid=100&cit=true&toLength='$toLength'&boatsAddedSelected=-1&fromLength='$fromLength'&ftid=101&fromPrice='$fromPrice'&man='$man'&slim=quick&spid=131&spid=132&No=0&ps=1000'

wget -O result.txt $toGet
grep -A1 make-model result.txt | grep href | cut -d\" -f2>results.txt

for x in `cat results.txt`
do 
  URL="http://www.yachtworld.com"$x
  # boat=`echo $x | cut -d\/ -f4`
  # echo -n "Boat-title: "$boat >> final.txt
  wget -O temp.txt $URL
  grep 'boat-title\|boat-price\|boat-location\|Current\ Price:\|Builder:\|Designer:\|LOA:\|Maximum\ Draft:\|Engine\ Brand:\|Year\ Built:\|Engine\ Model:\|Engine\ Hours:\|Engine\ Power\|Fresh\ Water\ Tanks:\|Fuel\ Tanks:\|Holding\ Tanks:' temp.txt | sed -e 's/&nbsp;//g' | sed -e 's/  //g' | sed -e 's/\t//g' >> final.txt
  echo " " >> final.txt
done
# remove html tags
sed -e 's/<[^>]*>//g' final.txt

#grep 'boat-title\|Current\ Price:\|Builder:\|Designer:\|LOA:\|Maximum\ Draft:\|Engine\ Brand:\|Year\ Built:\|Engine\ Model:\|Engine\ Hours:\|Engine\ Power\|Fresh\ Water\ Tanks:\|Fuel\ Tanks:\|Holding\ Tanks:' final.txt


# Current Price:
# Builder:
# Designer:
# Keel:
# LOA:
# Beam:
# LWL:
# Maximum Draft:
# Dispalcement:
# Bridge Clearance:
# Total Power:
# Engine Brand:
# Year Built:
# Engine Model:
# Engine Hours:
# Engine Power:
# Headroom:
# Fresh Water Tanks:
# Fuel Tanks:
# Holding Tanks:
