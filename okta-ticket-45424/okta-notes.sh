# Okta Auth method with Vault

### Setup

Export the `environment variable`:
```shell
$ export VAULT_ADDR="http://127.0.0.1:8200"
```

Enable Okta
```
$ vault auth enable okta
```

Configure Vault to communicate to my Okta account
```
vault write auth/okta/config \
   base_url="okta.com" \
   org_name="dev-xxxxxx" \
   api_token="api-token"
```

Map an Octa group to the Vault policy
```shell
vault write auth/okta/groups/scientists policies=nuclear-reactor
```

vault write auth/okta/groups/engineers policies=autopilot
vault write auth/okta/users/tesla groups=engineers