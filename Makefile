include $(TOPDIR)/rules.mk

PKG_NAME:=dns2tcp
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/zfl9/dns2tcp.git
PKG_SOURCE_VERSION:=a9ea743938a04357120a629637d6855f24820713
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)

PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=libuv

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=pexcn <i@pexcn.me>

include $(INCLUDE_DIR)/package.mk

define Package/dns2tcp
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Utility to convert DNS query from UDP to TCP
	URL:=https://github.com/zfl9/dns2tcp
endef

define Package/dns2tcp/description
Utility to convert DNS query from UDP to TCP.
endef

define Package/dns2tcp/conffiles
/etc/config/dns2tcp
endef

#CFLAGS += -I$(STAGING_DIR)/usr/include
#LDFLAGS += -L$(STAGING_DIR)/usr/lib
#MAKE_VARS += INCLUDES="-I$(STAGING_DIR)/usr/include"
#MAKE_VARS += LDFLAGS="-L$(STAGING_DIR)/usr/lib"
MAKE_FLAGS += INCLUDES="-I$(STAGING_DIR)/usr/include"
MAKE_FLAGS += LDFLAGS="-L$(STAGING_DIR)/usr/lib"

#CFLAGS += -I$(STAGING_DIR)/usr
#LDFLAGS += -L$(STAGING_DIR)/usr
#MAKE_VARS += INCLUDES="-I$(STAGING_DIR)/usr"
#MAKE_VARS += LDFLAGS="-L$(STAGING_DIR)/usr"
#MAKE_FLAGS += INCLUDES="-I$(STAGING_DIR)/usr"
#MAKE_FLAGS += LDFLAGS="-L$(STAGING_DIR)/usr"

define Package/dns2tcp/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dns2tcp $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/dns2tcp.init $(1)/etc/init.d/dns2tcp
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/dns2tcp.config $(1)/etc/config/dns2tcp
endef

$(eval $(call BuildPackage,dns2tcp))