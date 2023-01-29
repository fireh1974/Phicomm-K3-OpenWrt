#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP 
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改root密码
#password=$(openssl passwd -1 'admin')
#sed -i "s|root::0:0:99999:7:::|root:$password:0:0:99999:7:::|g" package/base-files/files/etc/shadow

#sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
#只生成k3固件
#phicomm_k3 的名字你对照你的源码自己修改下就好了，有phicomm_k3或者phicomm-k3

####### Set argon as default theme
sed -i 's/luci-theme-bootstrap/luci-theme-argonne/g' feeds/luci/collections/luci/Makefile

echo '修改主机名'
sed -i "s/hostname='OpenWrt'/hostname='Phicomm-K3'/g" package/base-files/files/bin/config_generate
cat package/base-files/files/bin/config_generate |grep hostname=
echo '=========Alert hostname OK!========='

echo '移除主页跑分信息显示'
sed -i 's/ <%=luci.sys.exec("cat \/etc\/bench.log") or ""%>//g' package/lean/autocore/files/arm/index.htm
echo '=========Remove benchmark display in index OK!========='

echo '添加alist'
#需要 golang 1.19.x 版本（在 ./scripts/feeds install -a 操作之后更换 golang 版本）
#rm -rf feeds/packages/lang/node
#svn co https://github.com/openwrt/packages/trunk/lang/node feeds/packages/lang/node
rm -rf feeds/packages/lang/golang
svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang
echo '=========alist OK!========='

# Add Screenctrl
#rm -rf package/lean/k3screenctrl
#rm -rf package/lean/luci-app-k3screenctrl
#git clone https://github.com/lwz322/luci-app-k3screenctrl.git package/lean/luci-app-k3screenctrl
#git clone https://github.com/lwz322/k3screenctrl_build.git package/lean/k3screenctrl
#wget -nv https://github.com/393435992/k3screen-fix-patch/raw/main/k3screen/000-k3screen.patch  -P package/lean/k3screenctrl/patches
