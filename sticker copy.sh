#!/bin/sh

if [ -z "$1" ]; then
echo "Create app"
echo $PWD
ruby /Users/hunghoang/imsticker/lib/imsticker.rb;
exit;
fi

if [ -z "$2" ]; then
echo "Pls enter id of line store";
exit;
fi

if [ ! -d "$1" ]; then
    # Control will enter here if $DIRECTORY exists.
    mkdir -p ./$1
    cd ./$1

else
    cd ./$1
fi


if [ ! -z "$3" ]; then
echo "GET PNG FILES";
mkdir -p ./stickers;
cd ./stickers;
curl -sS http://dl.stickershop.line.naver.jp/products/0/0/1/$2/iphone/stickers@2x.zip > file.zip

unzip file.zip;
rm file.zip;

find . -name "*key*" -exec rm -rf {} \;
find . -name "*tab_*" -exec rm -rf {} \;
find . -name "productInfo.meta" -exec rm -rf {} \;
cd ..;

else
echo "GET GIF FILES";
curl -sS http://dl.stickershop.line.naver.jp/products/0/0/1/$2/iphone/stickerpack@2x.zip > file.zip;
unzip file.zip;
rm file.zip;


if [ -d "./animation@2x" ]; then
mv ./animation@2x ./stickers
fi

for f in ./stickers/*.png;
do
/Users/hunghoang/Desktop/Stickers/apng2gif "$f";
rm $f;
done

fi
file_name="$1";
file_name="${file_name//_/ }";

echo '{"name":"'"$file_name"'",\n"website": "https://twitter.com/hunght"}' > info.json


curl -LOk https://github.com/hunght/sticker_fastlane_template/archive/master.zip;
unzip master.zip  -d ./;
mv -f ./sticker_fastlane_template-master ./fastlane
rm master.zip;

echo $PWD
sed -i -e 's/{Appname}/'"$file_name"'/g' ./fastlane/metadata/en-US/description.txt

numfiles=(./stickers/*.gif)
numfiles=${#numfiles[@]}
if [ "$numfiles" -gt 1 ]; then
    numfiles=${#numfiles[@]}' animated (GIF)'
else
    numfiles=(./stickers/*.png)
    numfiles=${#numfiles[@]}
fi
echo "$numfiles"

sed -i -e 's/{numberOfStickers}/'"$numfiles"'/g' ./fastlane/metadata/en-US/description.txt

open ./
open ./fastlane/metadata/en-US/description.txt

