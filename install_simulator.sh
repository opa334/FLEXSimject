set -e

make

THEOS_OBJ_DIR=./.theos/obj/iphone_simulator/debug

#install tweak into simject folder

rm -rf /opt/simject/FLEXSimject.plist ||:
cp -rfv ./FLEXSimject.plist /opt/simject
rm -rf /opt/simject/FLEXSimject.dylib ||:
cp -rfv $THEOS_OBJ_DIR/FLEXSimject.dylib /opt/simject

resim
