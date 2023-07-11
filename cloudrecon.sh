#!/bin/bash

{
curl -s 'https://kaeferjaeger.gay/sni-ip-ranges/amazon/ipv4_merged_sni.txt' & \
curl -s 'https://kaeferjaeger.gay/sni-ip-ranges/digitalocean/ipv4_merged_sni.txt' & \
curl -s 'https://kaeferjaeger.gay/sni-ip-ranges/google/ipv4_merged_sni.txt' & \
curl -s 'https://kaeferjaeger.gay/sni-ip-ranges/microsoft/ipv4_merged_sni.txt' & \
curl -s 'https://kaeferjaeger.gay/sni-ip-ranges/oracle/ipv4_merged_sni.txt'
}