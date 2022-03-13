import paho.mqtt.client as mqtt
import requests
from requests.auth import HTTPBasicAuth

# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))
    blocking_disabled()

    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe("$SYS/#")

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, message):
    # print(msg.topic+" "+str(msg.payload))
    if message.topic == 'focus-time':
        print("Focus time mqtt message detected")
        blocking_enabled()
        
def blocking_enabled():
    requests.post( 'http://adguard/control/dns_config', 
      json={'protection_enabled': True},
      auth=HTTPBasicAuth('admin', 'password')
    )

def blocking_disabled():
    requests.post( 'http://adguard/control/dns_config', 
      json={'protection_enabled': False},
      auth=HTTPBasicAuth('admin', 'password')
    )

client = mqtt.Client("adguard-middleware")
client.on_connect = on_connect
client.on_message = on_message

print("Attempting to connect")
client.connect("mosquitto", 1883, 60)
client.subscribe('focus-time')

# Blocking call that processes network traffic, dispatches callbacks and
# handles reconnecting.
# Other loop*() functions are available that give a threaded interface and a
# manual interface.
client.loop_forever()
print("Reached end")
