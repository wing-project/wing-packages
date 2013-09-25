#!/bin/sh 

# Copyright (c) 2013, Roberto Riggio
# 
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions    
# are met:
# 
#   - Redistributions of source code must retain the above copyright 
#     notice, this list of conditions and the following disclaimer.
#   - Redistributions in binary form must reproduce the above copyright 
#     notice, this list of conditions and the following disclaimer in 
#     the documentation and/or other materials provided with the 
#     distribution.
#   - Neither the name of the CREATE-NET nor the names of its 
#     contributors may be used to endorse or promote products derived 
#     from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

CHANNEL=
HWDDR=
MASTER_IP=
MASTER_PORT=
IFNAME=
DEBUGSFS=
VIRTUAL_IFNAME=
DEBUG="false"

usage() {
	echo "Usage: $0 -c <CHANNEL> -m <HWADDR> -a <MASTER_IP> -p <MASTER_PORT> -i <IFNAME> -f <DEBUGFS> -v <VIRTUAL_IFNAME>"
	exit 1
}	

while getopts "hdc:m:a:p:i:f:v:" OPTVAL
do
	case $OPTVAL in
	c) CHANNEL="$OPTARG"
	  ;;
	m) HWADDR="$OPTARG"
	  ;;
	a) MASTER_IP="$OPTARG"
	  ;;
	p) MASTER_PORT="$OPTARG"
	  ;;
	i) IFNAME="$OPTARG"
	  ;;
	f) DEBUGSFS="$OPTARG"
	  ;;
	v) VIRTUAL_IFNAME="$OPTARG"
	  ;;
	d) DEBUG="true"
	  ;;
	h) usage
	  ;;
	esac
done

[ "$CHANNEL" = "" -o "$HWADDR" = "" -o "$MASTER_IP" = "" -o "$MASTER_PORT" = "" -o "$IFNAME" = "" ] && {
	usage
}

echo """rates :: AvailableRates(DEFAULT 12 24 36 48 108);

ControlSocket(\"TCP\", 6777);

sched :: PrioSched()
  -> RadiotapEncap()
  -> ToDevice ($IFNAME);

mngt :: Queue(50)
  -> SetTXRate(12)
  -> [0] sched;

FromHost($VIRTUAL_IFNAME)       
  -> epsb :: EmpowerPowerSaveBuffer(EL el, CAPACITY 50)
  -> EmpowerWifiEncap(EL el, DEBUG $DEBUG)
  -> Queue(50)
  -> SetTXRate(12)
  -> [1] sched;

FromDevice($IFNAME, PROMISC false, OUTBOUND true, SNIFFER false)
  -> RadiotapDecap()
  -> FilterPhyErr()
  -> FilterTX()
  -> WifiDupeFilter()
  -> wifi_cl :: Classifier(0/08%0c 1/01%03, // data
                           0/00%0c);        // mgt

  ctrl :: Socket(TCP, $MASTER_IP, $MASTER_PORT, CLIENT true, VERBOSE true)
    -> el :: EmpowerLVAPManager(HWADDR $HWADDR, EBS ebs, PERIOD 5000, DEBUGFS $DEBUGFS, DEBUG $DEBUG)
    -> ctrl;

  wifi_cl [0] 
    -> EmpowerPowerSaveFilter(EPSB epsb, EL el)
    -> EmpowerWifiDecap(EL el, DEBUG $DEBUG) 
    -> ToHost($VIRTUAL_IFNAME); 

  wifi_cl [1] 
    -> mgt_cl :: Classifier(0/40%f0,  // probe req
                            0/b0%f0,  // auth req
                            0/00%f0); // assoc req

  mgt_cl [0] 
    -> ebs :: EmpowerBeaconSource(RT rates, EL el, CHANNEL $CHANNEL, PERIOD 100, DEBUG $DEBUG) 
    -> mngt;

  mgt_cl [1] 
    -> EmpowerOpenAuthResponder(RT rates, EL el, DEBUG $DEBUG) 
    -> mngt;

  mgt_cl [2] 
    -> EmpowerAssociationResponder(RT rates, EL el, DEBUG $DEBUG) 
    -> mngt;

"""

