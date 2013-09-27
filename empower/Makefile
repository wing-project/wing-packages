#
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=empower
#PKG_VERSION:=20130917
PKG_RELEASE:=1
#PKG_REV:=341d15f4471453ff493024e12414d7c4bd88c2fd

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
#PKG_SOURCE_URL:=git://github.com/rriggio/click.git
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_SOURCE_VERSION:=$(PKG_REV)
#PKG_SOURCE_PROTO:=git

include $(INCLUDE_DIR)/package.mk

define Package/empower
	SECTION:=net
	CATEGORY:=Network
	TITLE:=The EmPOWER Agent
	MAINTAINER:=Roberto Riggio <roberto.riggio@create-net.org>
	DEPENDS:=+kmod-tun +libpcap +libstdcpp
	URL:=http://www.read.cs.ucla.edu/
endef

define Package/empower/Description
	The EmPOWER Agent
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) /home/rriggio/src/click/* $(PKG_BUILD_DIR)/
endef

EXTRA_CFLAGS=-MD

CONFIGURE_ARGS += \
	--enable-tools=host \
	--enable-userlevel \
	--enable-wifi \
	--enable-empower \
	--disable-linuxmodule \
	--disable-dynamic-linking \

define Build/Compile
	$(call Build/Install/Default, install)
endef

define Package/empower/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/share/click
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/etc/config/
	$(CP) ./files/empower.config $(1)/etc/config/empower
	$(INSTALL_BIN) ./files/empower.init $(1)/etc/init.d/empower
	$(INSTALL_BIN) ./files/empower_config.sh $(1)/usr/bin/empower_config.sh 
	$(CP) $(PKG_BUILD_DIR)/conf/wing/write_handler $(1)/usr/bin/
	$(CP) $(PKG_BUILD_DIR)/conf/wing/read_handler $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/click $(1)/usr/bin/click
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/click-align $(1)/usr/bin/click-align
	$(CP) $(PKG_INSTALL_DIR)/usr/share/click/elementmap.xml $(1)/usr/share/click/elementmap.xml
endef

$(eval $(call BuildPackage,empower))

