# docker-periodic-rsync-storj
=====================
Docker image: Periodic remote backup - rsync and send to Storj DCS

***docker-periodic-rsync-storj*** is a [*Docker*](http://www.docker.com/) image based on *Alpine Linux* with *cron*, *ssh*, *tar*, *wget*, *curl*, *unzip*, *bash* and [*rsync*](http://en.wikipedia.org/wiki/Rsync) periodic remote *rsync* copy jobs, packaging and send backup to [*Storj DCS*](https://www.storj.io/).

Usage
=====

Requirements:

- setup passwordless SSH login on remote machines ([setup](http://www.tecmint.com/ssh-passwordless-login-using-ssh-keygen-in-5-easy-steps/))
- setup StorJ uplink CLI ([setup](https://docs.storj.io/dcs/getting-started/quickstart-uplink-cli/))
- `/root/.ssh`: mount your passwordless SSH public and private keys (`id_rsa`/`id_rsa.pub`, chown to user `root`)
- `/data`: mount preferred target directory to backup and with backup script
- `/var/spool/cron/crontabs`: mount your crontab file (for periodic usage)
- `/root/.config/storj`: mount your storj CLI (uplink) config folder (default `/home/<user>/.config/storj/uplink`)


Prepare crontab file `/srv/backup/cron.d/root`:

```
# m h dom mon dow  command
30 5   *   *   *  bash /data/backup.sh  > /dev/null 2>&1
```

RUN:
```bash
$ docker run -d -v /srv/backup/.ssh:/root/.ssh -v /srv/backup/cron.d:/var/spool/cron/crontabs -v /srv/backup/data:/data -v /srv/backup/storj:/root/.config/storj --name backup matt08/docker-periodic-rsync-storj
```

TODO
=====
* Upload sample backup.sh file with explanation
