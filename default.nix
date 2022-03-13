let 
  pkgs = (import <nixpkgs> {});#.pkgsCross.aarch64-multiplatform;
  adguard_config = pkgs.writeText "AdGuardHome.yaml" ''
bind_host: 0.0.0.0
bind_port: 80
beta_bind_port: 0
users:
- name: admin
  password: $2a$10$RagxIedfyNjr5D8vyODIt.3BKM3D.OncLmjuB3BJjwpMNnkKBXdUu
auth_attempts: 5
block_auth_min: 15
http_proxy: ""
language: ""
rlimit_nofile: 0
debug_pprof: false
web_session_ttl: 720
dns:
  bind_hosts:
  - 0.0.0.0
  port: 53
  blocked_services:
    - youtube
    - reddit
    - whatsapp
    - twitter
    - tiktok
    - discord
    - netflix
    - steam
    - telegram
    - instagram
    - facebook
  user_rules: []
  statistics_interval: 1
  querylog_enabled: false
  querylog_file_enabled: false
  querylog_interval: 90
  querylog_size_memory: 1000
  anonymize_client_ip: false
  protection_enabled: true
  blocking_mode: default
  blocking_ipv4: ""
  blocking_ipv6: ""
  blocked_response_ttl: 10
  parental_block_host: family-block.dns.adguard.com
  safebrowsing_block_host: standard-block.dns.adguard.com
  ratelimit: 20
  ratelimit_whitelist: []
  refuse_any: true
  upstream_dns:
  - 1.1.1.1
  upstream_dns_file: ""
filters:
- enabled: false
  url: https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
  name: AdGuard DNS filter
  id: 1
- enabled: false
  url: https://adaway.org/hosts.txt
  name: AdAway Default Blocklist
  id: 2
- enabled: false
  url: https://www.malwaredomainlist.com/hostslist/hosts.txt
  name: MalwareDomainList.com Hosts List
  id: 4
whitelist_filters: []
clients: []
tls:
  enabled: false
  server_name: ""
  force_https: false
verbose: false
schema_version: 10
  '';
in
pkgs.dockerTools.buildImage {
  name = "red-button-dns";
  contents = [
    pkgs.mosquitto
    pkgs.bashInteractive
    pkgs.adguardhome
    pkgs.hello
    pkgs.busybox
    pkgs.ldns # Drill for DNS debugging
  ];
  config = {
    Cmd = [ "adguardhome" "-c" adguard_config "--no-check-update"];
  };
}
