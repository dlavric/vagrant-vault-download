#!/usr/bin/env bash

# check for tools we need
which curl wget unzip jq &>/dev/null || {
  apt-get install -y curl wget unzip jq
}

# VAULT variable is set in the Vagrantfile
# if not set, we go for the latest version

[ "${VAULT}" ] || {
  VAULT=$(curl -sL https://releases.hashicorp.com/vault/index.json | jq -r '.versions[].version' | sort -V | egrep -v 'ent|beta|rc|alpha' | tail -n1)
}

cd /vagrant
[ -f vault_${VAULT}_linux_amd64.zip ] || {
  wget https://releases.hashicorp.com/vault/${VAULT}/vault_${VAULT}_linux_amd64.zip
}

cd /usr/local/bin
unzip -o /vagrant/vault_${VAULT}_linux_amd64.zip

[ -f /etc/vault.d/server.hcl ] || {
  curl -sL https://raw.githubusercontent.com/kikitux/curl-bash/master/vault-dev-inmem/vault.sh | bash
}

systemctl daemon-reload
systemctl restart vault

cp /root/.vault-token /home/vagrant/.vault-token
chown -R vagrant: /home/vagrant/.vault-token

export VAULT_ADDR=http://0.0.0.0:8200
vault version
vault status
