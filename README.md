`nix-build`
`docker load < result`

Running:
`docker run -p 3000:3000 -p 3001:80 -p 53:53/udp <imagename>`

To drop into a shell:
`docker run -it --entrypoint /bin/bash -p 3000:3000 -p 3001:80 -p 53:53 <imagename>`

# Adguard

The included config is the default with a few changes:
- username: `admin`, password: `password`

To configure it, you can review the configuration options here: https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration

# Customize what to block
Change the array of services in: `blocked_services`. Full list is in the [Adguard Repo in SERVICES](https://github.com/AdguardTeam/AdGuardHome/blob/master/client/src/helpers/constants.js)
OR
just add the rule for blocking that you want. For example, to block all of Slack (so many distracting notifications!!) and it's subdomains: `||slack.com^` as new line in the `user_rules`. More details on how to write the rules is on the [Adguard page](https://github.com/AdguardTeam/AdGuardHome/wiki/Hosts-Blocklists#adblock-style)

# How it works

To recreate to blocking you can run using `httpie`: `http -a admin:password POST http://localhost:3001/control/dns_config <<<'{"protection_enabled": true}'`
