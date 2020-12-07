# docker - SQUID docker with SSL and LDAP auth

I've written this to enable some of the teams to get access to our app's UIs on AWS. We needed to allow only authenticated users to get access, and only to some URL. These URLs are published in HTTPS, so I needed to read the destination and block it if not part of the deployment

The easiest way to achieve this was docker.

### Requisites:
Create a directory for squid config files (ie `/mnt/squid`) and copy the `squid.conf` file, the `ldap_password` file and the `wl_allowed` file.
The first one is obviously the squid configuration. The second, is the password for LDAP bind (the user is specified while creating the docker), the third is a regex list of allowed sites.

### Build:

- clone this repository
- `docker build -t squid-ssl .`
- `docker run --restart="always" -d --name squid -p 8443:3128 -v /mnt/squid/wl_allowed:/etc/squid/wl_allowed -v /mnt/squid/squid.conf:/etc/squid/squid.conf -v /mnt/squid/ldap_password:/etc/squid/ldap_password squid-ssl`

Note: Change the port to fit your needs. Also, the files mounted are just one of the ways you can configure the docker. You can also create a volume, and then change the files in there, if you want create multiple dockers using the same config, for example. Or, you can copy the whole content of `/etc/squid` into `/mnt/squid` and then mount `/mnt/squid` to `/etc/squid`. 
