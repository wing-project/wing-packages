#
# Copyright (C) 2013 Roberto Riggio
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=energino
PKG_VERSION:=20130729
PKG_RELEASE:=1
PKG_REV:=44bcba03f9cd3f354b119ac2cf8ee67e7ec92f51

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
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(INSTALL_DIR) $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/etc/xively.conf $(1)/etc/
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)/
	$(INSTALL_BIN) ./files/xively.init $(1)/etc/init.d/xively
	$(LN) $(PYTHON_PKG_DIR)/energino/xively_client.py $(1)/usr/bin/xively_client
	$(LN) $(PYTHON_PKG_DIR)/energino/energino.py $(1)/usr/bin/energino
endef

$(eval $(call BuildPackage,energino))
