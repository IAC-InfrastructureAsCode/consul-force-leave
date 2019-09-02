# CONSUL FORCE LEAVE

Schedule force-leave for unproperly removing "failed" node from consul cluster.

## Concepts
* When the nodes from consul members is on "left" state, it's actually still alive and it will eventually rejoin the cluster.
* The `force-leave` is a method for remove "failed" nodes.
* Consul will try to reconnect the "failed" nodes periodically by the time (default by 72 hours).
* You can't rejoin the "failed" node until you running this `force-leave`.
* References to [consul documentation](https://www.consul.io/docs/index.html)

## Configurations
* Configure / edit your all variable `CONSUL_SERVER` in all bash script (`consul-leave-daily.sh`, `consul-leave-dday.sh`, `consul-leave-weekly.sh`)
  ```
  CONSUL_SERVER="http://DNS-OR-IP-CONSUL-SERVER:8500"
  ```
  With your consul server address.
* Setup cronjob
  ```
  crontab -e
  ```
* Add last line:
  ```
  ## Daily Force Leave every 30 minutes
  */30 * * * * bash /root/consul-leave-dday.sh

  ## Daily Force Leave at 1.30pm
  30 1 * * * bash /root/consul-leave-daily.sh

  ## Weekly Force Leave at 2.30pm Friday
  30 2 * * 5 bash /root/consul-leave-weekly.sh
  ```

> **Notes:**
> * You can copy `crontab.lst` to `/etc/cron.d/consul-backup` for default cronjob.
>   ```
>   sudo cp crontab.lst /etc/cron.d/consul-leave
>   ```
> * Logs `force-leave` will save to `/var/log/consul-force-leave`
> -----

## Running Manual
```
cd /root
./consul-leave-daily.sh
./consul-leave-dday.sh
./consul-leave-weekly.sh
```

## License
Apache version 2.0
