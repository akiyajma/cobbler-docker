# Cobbler container image

Cobbler container image.

## Version

3.2.2

## How to build

```
docker-compose up -d
```

## Settings

### Custom settings

* ./cobbler-config/settings.yaml
* ./cobbler-config/dnsmasq.template
* ./cobbler-config/modules.conf

### Volumes

| type   | volume name     | soruce                            | target                        | 
| ------ | --------------- | --------------------------------- | ----------------------------- | 
| bind   | -               | ./cobbler-config/settings.yaml    | /etc/cobbler/settings.yaml    | 
| bind   | -               | ./cobbler-config/dnsmasq.template | /etc/cobbler/dnsmasq.template | 
| bind   | -               | ./cobbler-config/modules.conf     | /etc/cobbler/modules.conf     | 
| bind   | -               | /sys/fs/cgroup                    | /sys/fs/cgroup                | 
| volume | iso             | -                                 | /mnt                          | 
| volume | var_lib_cobbler | -                                 | /var/lib/cobbler              | 
| volume | var_www_cobbler | -                                 | /var/www/cobbler              | 


