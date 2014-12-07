openwrt-packages
================

Some extra packages for OpenWrt. 


Installation
------------

In order to add these packages as an additional feed in OpenWRT run:

> cd $TOPDIR
> 
> echo 'src-git extra git@github.com:rriggio/openwrt-packages-extra.git' >> feeds.conf.default
>
> ./scripts/feeds update extra

To install one package (e.g. the wing package) run:

> ./scripts/feeds install -a -p wing

