#
# Copyright (C) 2012 Roberto Riggio
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wing-extra
PKG_VERSION:=20121130
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/wing-extra
  TITLE:=Wireless mesh networking toolkit (Extras)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  MAINTAINER:=Roberto Riggio (roberto.riggio@create-net.org)
  DEPENDS:=+wing
  URL:=http://www.wing-project.org/
endef

define Package/wing-extra/Description 
	Wing is a wireless mesh routing software. The routing protocol
	is derived from Roofnet. It supports multiple radio interfaces and
	link quality routing using the ETX, ETT, and WCETT metrics.
endef 

define Build/Configure
endef

define Build/Compile
endef

define Package/wing-extra/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,wing-extra))

