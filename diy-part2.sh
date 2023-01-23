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

# Modify default IP ＆ Delete Password
sed -i 's/192.168.1.1/192.168.9.1/g' package/base-files/files/bin/config_generate
#sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ

echo '修改主机名'
sed -i "s/hostname='OpenWrt'/hostname='Phicomm-K3'/g" package/base-files/files/bin/config_generate
cat package/base-files/files/bin/config_generate |grep hostname=
echo '=========Alert hostname OK!========='

echo '移除主页跑分信息显示'
sed -i 's/ <%=luci.sys.exec("cat \/etc\/bench.log") or ""%>//g' package/lean/autocore/files/arm/index.htm
echo '=========Remove benchmark display in index OK!========='

# Change Default Theme
#rm -rf package/lean/luci-theme-argon  #删除原Argon主题
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon 
#rm -rf ./feeds/luci/themes/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git ./feeds/luci/themes/luci-theme-argon
# Add Screenctrl
#rm -rf package/lean/k3screenctrl
#rm -rf package/lean/luci-app-k3screenctrl
#git clone https://github.com/lwz322/luci-app-k3screenctrl.git package/lean/luci-app-k3screenctrl
#git clone https://github.com/lwz322/k3screenctrl_build.git package/lean/k3screenctrl
#wget -nv https://github.com/393435992/k3screen-fix-patch/raw/main/k3screen/000-k3screen.patch  -P package/lean/k3screenctrl/patches
