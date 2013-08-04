#
# Copyright (C) 2008-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=numpy
PKG_VERSION:=1.6.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://sourceforge.net/projects/numpy/files/NumPy/$(PKG_VERSION)/
PKG_MD5SUM:=0ab72b3b83528a7ae79c6df9042d61c6

PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/numpy
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=numpy
  URL:=http://numpy.sf.net
  DEPENDS:=+python-mini
endef

define Package/numpy/description
  Numpy
endef

define PyPackage/numpy/filespec
+|$(PYTHON_PKG_DIR)/numpy
endef

CFLAGS += -I $(PKG_BUILD_DIR)/numpy/core/include/numpy/fenv/

define Build/Compile
	cd $(PKG_BUILD_DIR) ; $(CONFIGURE_VARS) $(MAKE_VARS) python ./setup.py install --prefix="$(PKG_INSTALL_DIR)/usr"
endef

$(eval $(call PyPackage,numpy))
$(eval $(call BuildPackage,numpy))
