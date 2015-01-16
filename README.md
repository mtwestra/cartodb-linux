# cartodb-linux
setting up cartodb on a linux server

Server:

1. Configure a vps with linux Ubuntu 12.04 (Precise) LTS Bare OS

2. Copy the content of https://github.com/mtwestra/cartodb-linux to the root directory

3. Run `install-cartodb.sh`

4. Halfway, the install script stalls at the postgres prompt. To get out, type 'exit' followed by enter

5. At the end of the install script, the system parts are started.

Browser:

1. The settings use user=monkey and subdomain=monkey. This means that the server expects to run from `http://monkey.localhost.lan:3000/`. To accomplish this, add an entry to /etc/hosts to forward this address to your VPS, for example: 

`xx.xxx.xx.xxx monkey.localhost.lan`

2. Go to `http://monkey.localhost.lan:3000/dashboard` in the browser, and use the username and password as set in the settings file (in this case, both are 'monkey'). You should be able to login to the cartodb dashboard now.



