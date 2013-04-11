#
# Copyright (C) 2012 Roberto Riggio
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cinder
PKG_VERSION:=20121130
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/cinder
  TITLE:=Wing administration interface
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+haserl +wing 
  URL:=http://www.wing-project.org/
  VERSION:=$(PKG_VERSION)
endef

define Build/Compile
endef

define Package/cinder/install
	$(CP) -a ./files/* $(1)/
endef

$(eval $(call BuildPackage,cinder))

