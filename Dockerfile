FROM rockylinux/rockylinux:8

ENV COBBLER_RPM_URL https://download-ib01.fedoraproject.org/pub/epel/8/Modular/x86_64/Packages/c/cobbler-3.2.2-11.module_el8+14161+f12890f2.noarch.rpm
ENV PUPPET_RPM_URL https://yum.puppet.com/puppet7-release-el-8.noarch.rpm

RUN (cd /lib/systemd/system/sysinit.target.wants/; \
  for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  rm -f /lib/systemd/system/multi-user.target.wants/*;\
  rm -f /etc/systemd/system/*.wants/*;\
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*;\
  rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN set -ex \
  && dnf install -y epel-release $PUPPET_RPM_URL \
  && dnf install -y dnsmasq pykickstart yum-utils debmirror rsync-daemon \
          ipxe-bootimgs shim grub2-efi-x64-modules $COBBLER_RPM_URL puppet-agent syslinux net-tools python3-librepo \
  && cp -rf /usr/share/syslinux/* /var/lib/cobbler/loaders/ \
  && dnf remove -y syslinux \
  && dnf clean all \
  # fix debian repo support
  && sed -i "s/^@dists=/# @dists=/g" /etc/debmirror.conf \
  && sed -i "s/^@arches=/# @arches=/g" /etc/debmirror.conf \
  # enable services
  && systemctl enable cobblerd httpd dnsmasq rsyncd tftp

# DHCP Server
EXPOSE 67
# TFTP
EXPOSE 69
# Rsync
EXPOSE 873
# Web
EXPOSE 80
# Cobbler
EXPOSE 25151

COPY cobbler-init-sync.sh /usr/local/bin/cobbler-init-sync.sh
COPY puppet-ca-sing.sh /usr/local/bin/puppet-ca-sing.sh
COPY entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
