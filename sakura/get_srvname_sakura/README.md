sakura2ssh
==========
# Install
```
$ gem install get_srvname
```

# How to use
### 1. create configuration file
```
$ vim <config_file>
---
apikey:
  access_token: <access_token>
  access_token_secret: <access_token_secret>

```

### 2. run get_srvname_sakura
```
$ get_srvname_sakura update --config <config_file> [--tag <tag name>]
```

# License
get_srvname is released under the Apache License.


