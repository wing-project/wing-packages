#
# Copyright (C) 2013 Roberto Riggio
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=joule
PKG_VERSION:=20130804
PKG_RELEASE:=1
PKG_REV:=f0c249e99adad0236b94375797fc88f7bf8516b8

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=git://github.com/rriggio/joule.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/joule
  TITLE:=Joule
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+python +pyserial +python-json +numpy +kmod-usb-acm +click
  URL:=http://gforge.create-net.org/
endef

define Package/Joule/description
	Joule energy monitoring command line tools
endef

define Build/Compile
        $(call Build/Compile/PyMod,,install --prefix="$(PKG_INSTALL_DIR)/usr")
endef

define Package/joule/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/joule/
	$(INSTALL_DIR) $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/joule/* $(1)$(PYTHON_PKG_DIR)/joule/
	$(INSTALL_BIN) ./files/joule.init $(1)/etc/init.d/joule
	$(LN) $(PYTHON_PKG_DIR)/joule/virtualmeter.py $(1)/usr/bin/virtualmeter
endef

$(eval $(call BuildPackage,joule))
