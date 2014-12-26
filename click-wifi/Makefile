#
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=click-wifi
PKG_VERSION:=20141226
PKG_RELEASE:=1
PKG_REV:=2d68ba55057ee983a1e2a1ae28b40c892daf2897

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://github.com/rriggio/click-wifi.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git

include $(INCLUDE_DIR)/package.mk

define Package/click-wifi
	SECTION:=net
	CATEGORY:=Network
	TITLE:=The Click Modular Router with WiFi elements enabled
	MAINTAINER:=Roberto Riggio <roberto.riggio@create-net.org>
	DEPENDS:=+kmod-tun +libpcap +libstdcpp
	URL:=http://www.read.cs.ucla.edu/
endef

define Package/click-wifi/Description
	The Click Modular Router with WiFi elements enabled
endef

EXTRA_CFLAGS=-MD

CONFIGURE_ARGS += \
	--enable-tools=host \
	--enable-userlevel \
	--enable-wifi \
	--disable-linuxmodule \

define Build/Compile
	$(call Build/Install/Default, install)
endef

define Package/click-wifi/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/share/click
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/conf/wifi/write_handler $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/conf/wifi/read_handler $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/click $(1)/usr/bin/click
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/click-align $(1)/usr/bin/click-align
	$(CP) $(PKG_INSTALL_DIR)/usr/share/click/elementmap.xml $(1)/usr/share/click/elementmap.xml
endef

$(eval $(call BuildPackage,click-wifi))

