#
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=click
PKG_VERSION:=20130820
PKG_RELEASE:=1
PKG_REV:=0b30abef72f7efd14eb4ed672600a0085f19bd40

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=git://github.com/rriggio/click.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git

include $(INCLUDE_DIR)/package.mk

define Package/click
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Routing and Redirection
	TITLE:=The Click Modular Router
	MAINTAINER:=Roberto Riggio <roberto.riggio@create-net.org>
	DEPENDS:=+kmod-tun +libpcap +libstdcpp
	URL:=http://www.read.cs.ucla.edu/
endef

define Package/click/Description
	The Click Modular Router
endef

EXTRA_CFLAGS=-MD

CONFIGURE_ARGS += \
	--enable-tools=host \
	--enable-userlevel \
	--enable-wifi \
	--disable-linuxmodule \
	--disable-dynamic-linking \

define Build/Compile
	$(call Build/Install/Default, install)
endef

define Package/click/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/share/click
	$(CP) $(PKG_BUILD_DIR)/conf/wing/write_handler $(1)/usr/bin/
	$(CP) $(PKG_BUILD_DIR)/conf/wing/read_handler $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/click $(1)/usr/bin/click
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/click-align $(1)/usr/bin/click-align
	$(CP) $(PKG_INSTALL_DIR)/usr/share/click/elementmap.xml $(1)/usr/share/click/elementmap.xml
endef

$(eval $(call BuildPackage,click))

