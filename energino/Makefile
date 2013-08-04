#
# Copyright (C) 2013 Roberto Riggio
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=energino
PKG_VERSION:=20130804
PKG_RELEASE:=1
PKG_REV:=709c0f877b61260abc2d1953ea8c7a3fa97415de

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=git://github.com/rriggio/energino.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/energino
  TITLE:=Energino
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+python +pyserial +kmod-usb-acm
  URL:=http://gforge.create-net.org/
endef

define Package/Energino/description
	Energino energy monitoring command line tools
endef

define Build/Compile
        $(call Build/Compile/PyMod,,install --prefix="$(PKG_INSTALL_DIR)/usr")
endef

define Package/energino/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/energino/
	$(INSTALL_DIR) $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/etc/xively.conf $(1)/etc/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/energino/* $(1)$(PYTHON_PKG_DIR)/energino/
	$(INSTALL_BIN) ./files/xively.init $(1)/etc/init.d/xively
	$(LN) $(PYTHON_PKG_DIR)/energino/xively_client.py $(1)/usr/bin/xively_client
	$(LN) $(PYTHON_PKG_DIR)/energino/energino.py $(1)/usr/bin/energino
endef

$(eval $(call BuildPackage,energino))
