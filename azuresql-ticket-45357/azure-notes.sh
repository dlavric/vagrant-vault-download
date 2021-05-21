# Azure SQL Database Secrets engine

Check Terraform is installed:
```shell
$ terraform
```

### Setup

Export the `environment variable`:
```shell
$ export VAULT_ADDR="http://127.0.0.1:8200"
```

Enable the database secret engine, if not enabled already:
```shell
$ vault secrets enable -path=azuresql database
```

Configure a connection called "testvault" to connect to a database 
called "test-vault", using "azuresql" at the beginning of our path:
```shell
$ vault write azuresql/config/testvault \
    plugin_name=mssql-database-plugin \
    connection_url="server=hashisqlserver.database.windows.net;port=1433; \
    user id=admin;password=pAssw0rd;database=test-vault;app name=vault;" \
    allowed_roles="test"
```

```shell
$ vault write database/config/my-mssql-database \
    plugin_name=mssql-database-plugin \
    connection_url='sqlserver://{{username}}:{{password}}@localhost:1433' \
    allowed_roles="my-role" \
    username="vaultuser" \
    password="yourStrong(!)Password"
```

Add a role called "test" for use with the "testvault" connection:
```shell
$ vault write azuresql/roles/test \
    db_name=testvault \
    creation_statements="CREATE USER [{{name}}] WITH PASSWORD = '{{password}}';" \
    revocation_statements="DROP USER IF EXISTS [{{name}}]" \
    default_ttl="1h" \
    max_ttl="24h"
```

We can now use this role to dynamically generate credentials for the Azure SQL database, test-vault:
```shell
$ vault read azuresql/creds/test
```