#!/usr/bin/env bash

function print_help()
{
  echo "Easy 4-step NAT tool"
  echo "Usage: $0 internal-dev external-dev ip-range"
  echo ""
  echo "internal-dev      e.g. eth0"
  echo "external-dev      e.g. wlan0"
  echo "ip-range          e.g. 192.168.0.1/24"
}

INTIF=$1
EXTIF=$2
IPRNG=$3

if [[ $BASH_ARGC < 3 ]]; then
  print_help
else
  echo -n "Enabling ip_forward in /proc/sys/net/"
  echo 1 > /proc/sys/net/ipv4/ip_forward
  echo "   Enabling DynamicAddr.."
  echo "1" > /proc/sys/net/ipv4/ip_dynaddr

  echo -n "Setting firewall rules... "
  iptables -t nat -A POSTROUTING -s "$IPRNG" -o "$EXTIF" -j MASQUERADE
  iptables -A FORWARD -i "$EXTIF" -o "$INTIF" -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
  iptables -A FORWARD -i "$INTIF" -o "$EXTIF" -j ACCEPT
  iptables-save -f /etc/iptables/iptables.rules
  echo "done."
  echo "You have just enabled NAT from $INTIF to $EXTIF using range $IPRNG"
fi
