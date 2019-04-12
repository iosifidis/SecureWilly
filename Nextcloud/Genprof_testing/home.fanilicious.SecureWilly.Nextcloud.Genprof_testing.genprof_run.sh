# Last Modified: Fri Apr 12 17:12:17 2019
#include <tunables/global>

/home/fanilicious/SecureWilly/Nextcloud/Genprof_testing/genprof_run.sh {
  #include <abstractions/base>
  #include <abstractions/bash>
  #include <abstractions/nameservice>
  #include <abstractions/postfix-common>

  capability audit_write,

  /bin/bash ix,
  /bin/cat mrix,
  /bin/grep mrix,
  /bin/rm mrix,
  /bin/sleep mrix,
  /dev/tty rw,
  /etc/default/locale r,
  /etc/environment r,
  /etc/login.defs r,
  /etc/pam.d/* r,
  /etc/securetty r,
  /etc/security/pam_env.conf r,
  /etc/shadow r,
  /etc/sudoers r,
  /etc/sudoers.d/ r,
  /etc/sudoers.d/README r,
  /home/*/.docker/config.json r,
  /home/*/SecureWilly/Nextcloud/Genprof_testing/answer rw,
  /home/fanilicious/SecureWilly/Nextcloud/Genprof_testing/genprof_run.sh r,
  /lib{,32,64}/** mr,
  /proc/*/stat r,
  /proc/filesystems r,
  /proc/stat r,
  /proc/sys/kernel/cap_last_cap r,
  /proc/sys/kernel/hostname r,
  /proc/sys/kernel/ngroups_max r,
  /proc/sys/net/core/somaxconn r,
  /run/sudo/ts/fanilicious rwk,
  /run/utmp rk,
  /tmp/_MEIbs0JHk/ rw,
  /tmp/_MEIbs0JHk/* w,
  /tmp/_MEIbs0JHk/certifi/ rw,
  /tmp/_MEIbs0JHk/certifi/cacert.pem w,
  /tmp/_MEIbs0JHk/certifi/old_root.pem w,
  /tmp/_MEIbs0JHk/certifi/weak.pem w,
  /tmp/_MEIbs0JHk/compose/ rw,
  /tmp/_MEIbs0JHk/compose/GITSHA w,
  /tmp/_MEIbs0JHk/compose/config/ rw,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v1.json w,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v2.0.json w,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v2.1.json w,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v2.2.json w,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v2.3.json w,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v3.0.json w,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v3.1.json w,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v3.2.json w,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v3.3.json w,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v3.4.json w,
  /tmp/_MEIbs0JHk/compose/config/config_schema_v3.5.json w,
  /tmp/_MEIbs0JHk/include/ rw,
  /tmp/_MEIbs0JHk/include/python2.7/ rw,
  /tmp/_MEIbs0JHk/include/python2.7/pyconfig.h w,
  /tmp/_MEIbs0JHk/jsonschema/ rw,
  /tmp/_MEIbs0JHk/jsonschema/schemas/ rw,
  /tmp/_MEIbs0JHk/jsonschema/schemas/draft3.json w,
  /tmp/_MEIbs0JHk/jsonschema/schemas/draft4.json w,
  /tmp/_MEIbs0JHk/lib/ rw,
  /tmp/_MEIbs0JHk/lib/python2.7/ rw,
  /tmp/_MEIbs0JHk/lib/python2.7/config/ rw,
  /tmp/_MEIbs0JHk/lib/python2.7/config/Makefile w,
  /usr/bin/docker mrix,
  /usr/bin/sudo mrix,
  /usr/lib{,32,64}/** mr,
  /usr/local/bin/docker-compose mrix,

}