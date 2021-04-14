#!/usr/bin/env bash

# check for tools we need
which curl wget unzip jq &>/dev/null || {
  yum install -y curl wget unzip jq
}

# VAULT variable is set in th Vagrantfile
# if not set, we go for the latest version

[ "${VAULT}" ] || {
  VAULT=$(curl -sL https://releases.hashicorp.com/vault/index.json | jq -r '.versions[].version' | sort -V | egrep -v 'ent|beta|rc|alpha' | tail -n1)
}


cp /vagrant/sw/hosts /etc/hosts
echo 'vault.test' > /etc/hostname
hostname vault.test

export PATH=/usr/local/bin:${PATH}

cd /usr/local/bin
[ -f vault_${VAULT}_linux_amd64.zip ] || {
  wget https://releases.hashicorp.com/vault/${VAULT}/vault_${VAULT}_linux_amd64.zip
}

unzip -o vault_${VAULT}_linux_amd64.zip

[ -f /etc/vault.d/server.hcl ] || {
  curl -sL https://raw.githubusercontent.com/kikitux/curl-bash/master/vault-dev-inmem/vault.sh | bash
}

cd /vagrant
[ -d sw ] || mkdir sw
cd sw
touch vault.service
yes | cp /etc/systemd/system/vault.service /vagrant/sw/vault.service

systemctl daemon-reload
systemctl restart vault

cp /root/.vault-token /home/vagrant/.vault-token
chown -R vagrant: /home/vagrant/.vault-token
export VAULT_ADDR=http://localhost:8200
