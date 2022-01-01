#!/bin/bash
source halium.env
cd $ANDROID_ROOT

# replace something
sed -i 's/external\/selinux/external\/selinux external\/libcurl/g' build/core/main.mk

./hybris-patches/apply-patches.sh --mb
sudo rm -rf \
          hardware/lineage/interfaces/light \
          vendor/qcom/opensource/thermal-engine
source build/envsetup.sh
virtualenv --python 2.7 ~/python27
source ~/python27/bin/activate
export USE_CCACHE=1
breakfast $DEVICE
make -j$(nproc) halium-boot systemimage

echo "md5sum halium-boot.img and system.img"
md5sum $ANDROID_ROOT/out/target/product/${DEVICE}/halium-boot.img
md5sum $ANDROID_ROOT/out/target/product/${DEVICE}/system.img
