openwrt-packages
================

Some personal packages for OpenWrt. These packages are tested with a more or 
less up-to-date version of OpenWrt trunk. My other repository named 'openwrt'
already incluse this feed.


Installation
------------

In order to add these packages as an additional feed in OpenWRT run:

> cd $TOPDIR
> 
> echo 'src-git openwrt-packages git://github.com/rriggio/openwrt-packages.git' >> feeds.conf.default
>
> ./scripts/feeds update openwrt-packages

To install one package (e.g. the wing package) run:

> ./scripts/feeds install -a -p wing

