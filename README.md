# docker-periodic-rsync-storj
Docker image: Periodic remote backup - rsync and send to Storj DCS

***docker-periodic-rsync-storj*** is a [*Docker*](http://www.docker.com/) image based on *Alpine Linux* with *cron*, *ssh*, *tar*, *wget*, *curl*, *unzip*, *bash* and [*rsync*](http://en.wikipedia.org/wiki/Rsync) periodic remote *rsync* copy jobs, packaging and send backup to [*Storj DCS*](https://www.storj.io/).

What does it do?
1. Sync with remote server via rsync
2. Packs a backup and compresses it
3. Sends a packed backup to Storj DCS
4. Deletes old backups from Storj DCS on a schedule

Usage
=====

Requirements:

- setup passwordless SSH login on remote machines ([setup](http://www.tecmint.com/ssh-passwordless-login-using-ssh-keygen-in-5-easy-steps/))
- setup StorJ uplink CLI ([setup](https://docs.storj.io/dcs/getting-started/quickstart-uplink-cli/))
- `/root/.ssh`: mount your passwordless SSH public and private keys (`id_rsa`/`id_rsa.pub`, chown to user `root`)
- `/data`: mount preferred target directory to backup and with backup script (`backup.sh`)
- `/root/.config/storj`: mount your storj CLI (uplink) config folder (default `/home/<user>/.config/storj/uplink`)

RUN:
```bash
$ docker run -d -v /srv/backup/.ssh:/root/.ssh -v /srv/backup/data:/data -v /srv/backup/storj:/root/.config/storj --name backup matt08/docker-periodic-rsync-storj
```
