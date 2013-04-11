#!/bin/sh 

version=$(opkg list_installed | sed -n 's/^cinder - \([0-9.]*\).*/\1/p')

