#!/bin/bash

rm ./*.txt

fromPrice=500
toPrice=120000
fromYear=1900
toYear=2017
fromLength=34
toLength=40
toExclude='oday\|j-boat\|O%27day\|Morgan\|Beneteau\|Hunter\|Bavaria\|Jeanneau\|Freedom\|Moorings\|DuFour\|Gemini\|Hanse\|Alerion\|Sunbeam\|j\/[0-9]'
#man='najad%2Cpacket%2Ctartan%2Ccabo+rico%2Cmason%2Ccape+dory%2Ccatalina'
#create link to all listings
toGet='http://www.yachtworld.com/core/listing/cache/searchResults.jsp?toPrice='$toPrice'&Ntk=boatsEN&type=%28Sail%29&fromYear='$fromYear'&searchtype=advancedsearch&hmid=102&sm=3&enid=100&toYear='$toYear'&luom=126&currencyid=100&cit=true&toLength='$toLength'&boatsAddedSelected=-1&fromLength='$fromLength'&ftid=101&fromPrice='$fromPrice'&slim=quick&rid=100&rid=101&rid=104&rid=105&No=0&ps=2000'
#&man='$man'

#get all listings
wget -O allListings.txt $toGet

#get indv boat listing page into results.txt
touch ./listingURLs.txt
chmod 777 ./listingURLs.txt
/bin/grep -A1 make-model allListings.txt|/bin/grep href|/usr/bin/cut -d\" -f2 > listingURLs.txt

#remove exclusions
/bin/cat listingURLs.txt | /bin/grep -iv $toExclude > temp.txt
mv temp.txt listingURLs.txt

#insert headers
echo 'boat-year|boat-title|boat-location-city|boat-location-state|Current Price|LOA|Maximum Draft|Engine Brand|Year Built|Engine Model|Engine Hours|Engine Power|Fresh Water Tanks|Fuel Tanks|Holding Tanks' > output.txt

#go through listing page and pull desired data
for x in `cat listingURLs.txt`
do 
  URL="http://www.yachtworld.com"$x
  wget -O temp.txt $URL
#  if grep -q boat-title temp.txt; then grep boat-title temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g' | sed -e 's/<div\ class=\"boat-title\">/Title:\ /g' | cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q boat-title temp.txt; then grep boat-title temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g' | sed -e 's/<div\ class=\"boat-title\">/Title:\ /g' | cut -d\: -f2 | cut -d\  -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q boat-title temp.txt; then grep boat-title temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g' | sed -e 's/<div\ class=\"boat-title\">/Title:\ /g' | cut -d\: -f2 | cut -d\  -f3,4,5,6 |tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q boat-location temp.txt; then grep boat-location temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g'  | sed -e 's/<div\ class=\"boat-location\">/Location:\ /g' | cut -d\: -f2 | cut -d, -f1 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q boat-location temp.txt; then grep boat-location temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g'  | sed -e 's/<div\ class=\"boat-location\">/Location:\ /g' | cut -d\: -f2 | cut -d, -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q Current\ Price: temp.txt; then grep Current\ Price: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g' | sed -e 's/US$ //g' | cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q LOA: temp.txt; then grep LOA: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g' | cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\r\n' '|' >> output.txt;fi
  if grep -q Maximum\ Draft: temp.txt; then grep Maximum\ Draft: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g'| cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q Engine\ Brand: temp.txt; then grep Engine\ Brand: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g'| cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q Year\ Built: temp.txt; then grep Year\ Built: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g'| cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q Engine\ Model: temp.txt; then grep Engine\ Model: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g'| cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q Engine\ Hours: temp.txt; then grep Engine\ Hours: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g'| cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q Engine\ Power: temp.txt; then grep Engine\ Power: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g'| cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q Fresh\ Water\ Tanks: temp.txt; then grep Fresh\ Water\ Tanks: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g' | cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q Fuel\ Tanks: temp.txt; then grep Fuel\ Tanks: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g' | cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  if grep -q Holding\ Tanks: temp.txt; then grep Holding\ Tanks: temp.txt | sed -e 's/&nbsp;/ /g' | sed -e 's/  //g' | sed -e 's/\t//g' | cut -d\: -f2 | tr '\n' '|' >> output.txt; else echo -n ":***" | cut -d\: -f2 | tr '\n' '|' >> output.txt;fi
  echo "=HYPERLINK($URL)" >> output.txt
done
# remove html tags
sed -e 's/<[^>]*>//g' output.txt | sed -e '/Pending/d' > finalOutput.txt

#open finalOutput.txt with excell
