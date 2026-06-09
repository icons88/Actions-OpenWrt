#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
# sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
# 登录密码为 空
sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

# 1. 解决 PassWall 依赖冲突：删除旧 feed 中可能残留的旧版 passwall 依赖组件（防止与新源冲突）
rm -rf feeds/packages/net/tuic-client
rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/net/v2ray-core
rm -rf feeds/packages/net/v2ray-geodata

# 2. 之前提到的 SmartDNS 修复（使用兼容分支避免 Rust 报错）
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
git clone --depth=1 -b sysuser https://github.com/pymumu/openwrt-smartdns.git package/smartdns
git clone --depth=1 https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

# 3. AdGuard Home 顺手添加
rm -rf feeds/luci/applications/luci-app-adguardhome
git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
