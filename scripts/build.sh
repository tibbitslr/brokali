#!/bin/bash

VERSION='0.1'

buildver=`cat .buildver`
nv=`python -c "print $buildver+1"`
echo $nv > .buildver

VERSION=$VERSION.$nv

flutter build apk --build-name=$VERSION
cp ./build/app/outputs/apk/release/app-release.apk ./rel/brokali-$VERSION.apk