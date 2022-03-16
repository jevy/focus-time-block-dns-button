# Getting Started

On a Raspberry Pi, install Docker. Then

1. Build a docker image for the Python app: `docker-compose build`
2. Run it: `docker-compose up -d`

# Configuring it

## What you want to Block

Visit http://<IP>:80/ to open up Adguard
- username: `admin`, password: `password`

Add the domains in the DNS filter
Or just turn on and off any of the pre-configured "services"
 

# Debugging

## The Adguard API to (un)block
To recreate to blocking you can run using `httpie`:
```http -a admin:password POST http://localhost:3001/control/dns_config <<<'{"protection_enabled": true}'```

## Sending MQTT messages

Install https://mosquitto.org/ on your local machine. Then you can:
- manually trigger a message to trigger the blocking: Just send any message to the `focus-time` topic: `mosquitto_pub -h <ip> -t focus-time -m "sup"`
- watch the mqtt events: `mosquitto_sub -h <ip> -t focus-time`
