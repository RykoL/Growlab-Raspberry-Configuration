# Growlab Raspberry pi configuration

## How to connect

Currently the raspberry pi is connected only via an internal local network
without DHCP with the following manual ip configuration.

``` sh
DHCP: disabled
IP: 192.168.178.10/24
MASK: 255.255.255.0
GATEWAY: 192.168.178.1
```

In order to connect from your machine to the raspberry pi make sure to configure
your ethernet interface through which you are connected shares a similar connection
e.g.

``` sh
DHCP: disabled
IP: 192.168.178.11/24 # Basically any ip expect .10 or .1 are valid
MASK: 255.255.255.0
GATEWAY: 192.168.178.1
```

### For MacOS (Venture)

1. Find the suitable network interface e.g. if you're using an usb-c dongle this
   might be USB 10/100/1000 LNA
2. Go to System Preferences -> Network -> {YOUR_NETWORK_INTERFACE}
3. Click on Details
4. In the navigation choose TCP/IP and apply the configuration from above.

### Check the connectivity 

The first thing to validate the network setup is to just ping the host e.g.

``` sh
➜  ~ ping 192.168.178.10                                                                                                                                                                                                                  ~
PING 192.168.178.10 (192.168.178.10): 56 data bytes
64 bytes from 192.168.178.10: icmp_seq=0 ttl=64 time=1.023 ms
64 bytes from 192.168.178.10: icmp_seq=1 ttl=64 time=0.643 ms
64 bytes from 192.168.178.10: icmp_seq=2 ttl=64 time=0.564 ms
```

Next thing to check is, if ssh works. If everything is setup properly you should
be able to see a password prompt

``` sh
ssh some-user@192.168.178.10
some-user@192.168.178.10's password:
```

### Troubleshooting

* In case ssh doesn't work one reason could be the firewall rules that only
  allow ssh connections from the `192.168.178.0/24` subnet
