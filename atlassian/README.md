# Atlassian services

```
# To start:
docker-compose up -d

# To kill:
docker-compose down
```

## First time startup

```
# Copied from:
# https://github.com/teamatldocker/confluence/blob/master/docker-compose.yml
# Thirdly, configure your Confluence yourself and fill it with a test license.
```

1. Enter license information
2. In Choose a Database Configuration choose PostgeSQL and press External Database
3. In Configure Database press Direct JDBC
4. In Configure Database fill out the form:

```
   Driver Class Name: org.postgresql.Driver
   Database URL: jdbc:postgresql://postgres-atlassian:5432/confluencedb
   User Name: confluence
   Password: password
```
