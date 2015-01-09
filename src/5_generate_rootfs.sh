#!/bin/sh

echo "generate rootfs...."

cd work

rm -rf rootfs

cd busybox
cd $(ls -d *)

cp -R _install ../../rootfs
cd ../../rootfs

rm -f linuxrc

mkdir -p dev
mkdir -p etc
mkdir -p proc
mkdir -p root
mkdir -p src
mkdir -p sys
mkdir -p tmp
chmod 1777 tmp

cd etc

cat > bootscript.sh << EOF
#!/bin/sh

dmesg -n 1
mount -t devtmpfs none /dev
mount -t proc none /proc
mount -t sysfs none /sys
ifconfig eth0 192.168.9.222 netmask 255.255.255.0
route add 0.0.0.0/0 gw 192.168.9.1
EOF

chmod +x bootscript.sh

cat > welcome.txt << EOF

  #####################################
  #                                   #
  #  Welcome to "Minimal Linux Live"  #
  #                                   #
  #####################################

EOF

cat > inittab << EOF
::sysinit:/etc/bootscript.sh
::restart:/sbin/init
::ctrlaltdel:/sbin/reboot
::once:cat /etc/welcome.txt
::respawn:/bin/cttyhack /bin/sh
tty2::once:cat /etc/welcome.txt
tty2::respawn:/bin/sh
tty3::once:cat /etc/welcome.txt
tty3::respawn:/bin/sh
tty4::once:cat /etc/welcome.txt
tty4::respawn:/bin/sh

EOF

cd ..

cat > init << EOF
#!/bin/sh

exec /sbin/init

EOF

chmod +x init

cp ../../*.sh src
cp ../../.config src
chmod +r src/*.sh
chmod +r src/.config

cd ../..
