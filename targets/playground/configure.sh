#!/bin/sh

_step_counter=0
step() {
	_step_counter=$(( _step_counter + 1 ))
	printf '\n\033[1;36m%d) %s\033[0m\n' $_step_counter "$@" >&2  # bold cyan
}

step 'Set up timezone'
setup-timezone -z Europe/Zurich

step 'Set up hostname'
cat > /etc/hosts <<-EOF
127.0.0.1 ${HOSTNAME:-alpine} ${HOSTNAME:-alpine}.local localhost
::1       ${HOSTNAME:-alpine} ${HOSTNAME:-alpine}.local localhost
EOF
echo "${HOSTNAME:-alpine}" > /etc/hostname

step 'Set up networking'
cat > /etc/network/interfaces <<-EOF
	iface lo inet loopback
	iface eth0 inet dhcp
EOF

ln -s networking /etc/init.d/net.lo
ln -s networking /etc/init.d/net.eth0

step 'Adjust rc.conf'
sed -Ei \
	-e 's/^[# ](rc_depend_strict)=.*/\1=NO/' \
	-e 's/^[# ](rc_logger)=.*/\1=YES/' \
	-e 's/^[# ](unicode)=.*/\1=YES/' \
	/etc/rc.conf

step 'Enable services'
rc-update add acpid default
rc-update add chronyd default
rc-update add crond default
rc-update add net.eth0 default
rc-update add net.lo boot
rc-update add termencoding boot
rc-update add sshd default

step 'Setup Cloud-init'
setup-cloud-init

cat <<EOF > /etc/motd
Welcome to Alpine!
EOF

mkdir -m 700 -p /root/.ssh
curl https://github.com/tuxpeople.keys | tee /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

chsh --shell /bin/bash root

cat <<'EOF' > /root/.bash_profile
PS1="[\u@\h:\w${_p}] "
export EDITOR=/usr/bin/vim
EOF

sleep 20
